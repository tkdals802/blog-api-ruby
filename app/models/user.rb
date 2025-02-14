class User < ApplicationRecord
  has_many :articles, dependent: :destroy

  has_secure_password #for password hashing

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: {minimum: 6} #password 長さ 6 以上
  validates :password_confirmation, presence: true
end
