class EnrollmentType < ApplicationRecord
  enum nature: { yes: 0, maybe: 1, no: 2 }

  belongs_to :organization

  validates :name, presence: true
  validates :nature, presence: true
end
