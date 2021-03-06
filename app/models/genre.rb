class Genre < ApplicationRecord
  default_scope { order(name: :asc) }

  # model relations
  has_many :listings, inverse_of: :genre

  # validations
  validates :name, presence: true

  # select options in listing create/update forms
  def self.select_options
    Genre.order("name").collect {|u| [u.name, u.id]}
  end

  # select options in search forms
  def self.search_select_options
    genre_list = Genre.all.collect {|u| [u.name, u.name]}
    genre_list.unshift(["--- All Genres ---", ""])
  end
end
