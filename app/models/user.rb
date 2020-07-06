class User < ApplicationRecord
  has_many :notes

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: { minimum: 5 }
end