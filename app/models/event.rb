class Event < ApplicationRecord
  has_and_belongs_to_many :locations
  has_and_belongs_to_many :organizations

  has_many :enrollments
  has_many :users, through: :enrollments

  belongs_to :organizer, class_name: 'Organization'

  validates :name, presence: true
  validates :starts_at, presence: true
  validates :ends_at, presence: true
  validates :organizations, presence: true
  validates :locations, presence: true
  validates :kegs, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validate :begin_is_before_end
  validate :location_is_free

  def long?
    self.ends_at - self.starts_at >= 12.hours
  end

  def assigned_bartenders
    self.enrollments.available.includes(:user).order('users.first_name').map(&:user)
  end

  def available_bartenders
    Membership.where(organization: self.organizations, bartender: true).order(active: :desc).includes(:user).order('users.first_name')
  end

  def bartenders_with_enrollments
    known = self.enrollments.index_by(&:user_id)
    self.available_bartenders.map{ |membership| [membership, known[membership.user.id]] }
  end

  protected

  def begin_is_before_end
    errors.add(:starts_at, _("can't be before the end")) if self.starts_at >= self.ends_at
  end

  def location_is_free
    self.locations.each do |location|
      next unless location.prevents_conflict
      errors.add(:locations, _("%{location} is occupied") % { location: location.name }) if location.conflicts?(self)
    end
  end
end
