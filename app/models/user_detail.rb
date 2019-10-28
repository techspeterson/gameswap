class UserDetail < ApplicationRecord
  belongs_to :user

  validate :username, presence: true
  validate :username, format: { with: /\A[a-zA-Z0-9_]*\z/, message: "should contain alphanumeric characters or underscores only"}
  validate :username, uniqueness:  { case_sensitive: false }

  has_one_attached :avatar
end
