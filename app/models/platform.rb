class Platform < ApplicationRecord
  has_many :listings, inverse_of: :platform
end
