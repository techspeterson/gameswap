class WishlistItem < ApplicationRecord
  # model relations
  belongs_to :user

  # validations
  validates :title, presence: true
end
