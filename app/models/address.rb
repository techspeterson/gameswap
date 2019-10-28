class Address < ApplicationRecord
  belongs_to :user
  belongs_to :country

  validates :address_line_1, :city, :postcode, presence: true
end
