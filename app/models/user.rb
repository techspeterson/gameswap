class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :authentication_keys => [:username]
  has_many :listings
  has_many :wishlist_items
  has_one :address
  has_one :user_detail

  validates :username, uniqueness: { case_sensitive: false }

  accepts_nested_attributes_for :user_detail, :address, :wishlist_items
end
