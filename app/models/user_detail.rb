class UserDetail < ApplicationRecord
  belongs_to :user

  validates :username, presence: true
  validates :username, length: { in: 5..15, too_short: "should be at least %{count} characters", too_long: "should be no more than %{count} characters" }
  validates :username, format: { with: /\A[a-zA-Z0-9_]*\z/, message: "should contain alphanumeric characters or underscores only"}
  validates :username, uniqueness:  { case_sensitive: false }

  has_one_attached :avatar
end
