class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :event
  belongs_to :enrollment_type

  validate :user_can_tend_event

  scope :available, -> { includes(:enrollment_type).where(enrollment_types: { nature: 'yes' }) }
  scope :past,      -> { includes(:event).where('events.ends_at <= ?', DateTime.now) }

  protected

  def user_can_tend_event
    unless self.user.memberships.where(organization: self.event.organizations, bartender: true).exists?
      errors.add(:event, _("does not accept tenders from %{organization}") % { organization: self.user.current_organization.name })
    end
  end
end
