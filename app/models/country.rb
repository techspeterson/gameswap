class Country < ApplicationRecord
  # model relations
  has_many :addresses

  # validations
  validates :name, presence: true
end
