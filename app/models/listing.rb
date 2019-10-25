class Listing < ApplicationRecord
  belongs_to :user
  belongs_to :platform
  belongs_to :genre
end
