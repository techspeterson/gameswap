class Genre < ApplicationRecord
  has_many :listings, inverse_of: :genre

  validates :name, presence: true
end
