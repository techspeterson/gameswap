class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :listings
  has_many :wishlist_items
  has_one :address
  has_one :user_detail

  accepts_nested_attributes_for :user_detail, :address
end
