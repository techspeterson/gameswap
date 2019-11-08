class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :authentication_keys => [:username]

  # model relations
  # all dependent entries are destroyed when a user is destroyed
  has_many :listings, dependent: :destroy
  has_many :wishlist_items, dependent: :destroy
  has_one :address, dependent: :destroy
  has_one :user_detail, dependent: :destroy
  has_many :purchases, dependent: :destroy

  # validations
  validates :username, length: { in: 5..15, too_short: "should be at least %{count} characters", too_long: "should be no more than %{count} characters" }
  validates :username, format: { with: /\A[a-zA-Z0-9_-]*\z/, message: "should contain alphanumeric characters, underscores or hyphens only"}
  validates :username, uniqueness: { case_sensitive: false }
  validates :email, uniqueness: { case_sensitive: false }

  # probably obsolete... but just in case
  accepts_nested_attributes_for :user_detail, :address, :wishlist_items
end