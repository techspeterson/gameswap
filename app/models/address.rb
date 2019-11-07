class Address < ApplicationRecord
  # model relations
  belongs_to :user
  belongs_to :country

  # validations
  validates :address_line_1, :city, :postcode, presence: true

  def emoji_flag
    ISO3166::Country.find_country_by_name(country.name).emoji_flag
  end
end
