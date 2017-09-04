class User < ApplicationRecord
  belongs_to :current_organization, class_name: 'Organization', optional: true

  has_many :enrollments
  has_many :events, through: :enrollments
  has_many :memberships
  has_many :organizations, through: :memberships

  validates :email, presence: true, uniqueness: true

  has_secure_password

  def authenticate(unencrypted_password)
    update(last_login: DateTime.now) if user = super(unencrypted_password)
    user
  end

  def name
    "#{self.first_name} #{self.last_name}" || '(none)'
  end

  def current_membership
    @current_membership ||= self.memberships.find_by_organization_id(self.current_organization&.id)
  end

  def tended
    self.enrollments.past.available.includes(:event)
  end

  def tended_count
    self.enrollments.past.available.count
  end

  def last_tended_event
    self.enrollments.past.available.order('events.starts_at DESC').first&.event
  end

  Membership::ROLES.each do |role|
    define_method "#{role.to_s}?" do
      self.current_membership&.send(role) || self.admin? || false
    end
  end
end
