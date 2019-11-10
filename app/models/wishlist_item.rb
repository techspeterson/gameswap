class WishlistItem < ApplicationRecord
  # wishlistitems are sorted alphabetically
  default_scope { order(title: :asc) }

  # model relations
  belongs_to :user

  # validations
  validates :title, presence: true
end
