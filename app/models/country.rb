class Country < ApplicationRecord
  # model relations
  has_many :addresses

  # validations
  validates :name, presence: true

  # select options in search forms
  def self.search_select_options
    genre_list = Country.all.collect {|u| [u.name, u.name]}
    genre_list.unshift(["--- All Countries ---", ""])
  end
end
