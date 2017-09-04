class Membership < ApplicationRecord
  ROLES = %i[active bartender planner manager].freeze

  belongs_to :organization
  belongs_to :user

  validates :user, uniqueness: { scope: :organization, message: _('is already a member') }

  def method_missing(method, *args, &block)
    self.user.send(method, *args)
  end
end
