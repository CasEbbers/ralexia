class Organization < ApplicationRecord
  extend FriendlyId

  default_scope { order(:name) }

  has_and_belongs_to_many :events

  has_many :enrollment_types
  has_many :memberships
  has_many :users, through: :memberships

  validates :name, presence: true

  friendly_id :name, use: :slugged

  mount_uploader :logo, LogoUploader
end
