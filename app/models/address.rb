class Address < ApplicationRecord
  # model relations
  belongs_to :user
  belongs_to :country

  # validations
  validates :address_line_1, :city, :postcode, presence: true
end
