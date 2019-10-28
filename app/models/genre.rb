class Genre < ApplicationRecord
  has_many :listings, inverse_of: :genre
end
