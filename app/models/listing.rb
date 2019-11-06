class Listing < ApplicationRecord
  # model relationships
  belongs_to :user
  belongs_to :platform
  belongs_to :genre

  # enum: condition of the game being listed (new, used, etc)
  enum condition: {
    new_and_unopened: 0,
    new_and_opened: 1,
    slightly_used: 2,
    well_used: 3
  }

  # field validations
  validates :title, :condition, :price, :platform, :genre, presence: true
  validates :title, length: { in: 5..100, too_short: "should be at least %{count} characters", too_long: "should be no more than %{count} characters" }
  validates :price, numericality: true

  # listing image validations (with active_storage_validations gem)
  has_one_attached :image
  validates :image, content_type: { in: [:png, :jpg, :jpeg, :gif], message: "must be a .png, .jpg or .gif" }
  validates :image, size: { less_than: 2.megabytes , message: 'must be less than 2MB' }
end
