class User < ApplicationRecord
  has_secure_password
  has_one :account, dependent: :destroy
  has_one_attached :avatar
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  accepts_nested_attributes_for :account

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true

  normalizes :email, with: -> email { email.strip.downcase }
end
