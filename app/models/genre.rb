class Genre < ApplicationRecord
  has_many :listings, inverse_of: :genre

  validates :name, presence: true

  def self.select_options
    genre_list = Genre.all.collect {|u| [u.name, u.name]}
    genre_list.unshift(["--- All Genres ---", ""])
  end
end
