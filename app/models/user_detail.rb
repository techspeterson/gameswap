class UserDetail < ApplicationRecord
  # model relations
  belongs_to :user

  # active storage validations for user avatar
  has_one_attached :avatar
  validates :avatar, content_type: { in: [:png, :jpg, :jpeg, :gif], message: "must be a .png, .jpg or .gif" }
  validates :avatar, size: { less_than: 200.kilobytes , message: 'must be less than 200KB' }
end
