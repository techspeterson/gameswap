class Listing < ApplicationRecord
  belongs_to :user
  belongs_to :platform
  belongs_to :genre

  enum condition: {
    new_and_unopened: 0,
    new: 1,
    slightly_used: 2,
    well_used: 3
  }

  validates :title, :condition, :price, :is_sold, :platform, :genre, presence: true
  validates :title, length: { in: 5..100, too_short: "should be at least %{count} characters", too_long: "should be no more than %{count} characters" }
  validates :price, :condition, numericality: true

  has_one_attached :image

end
