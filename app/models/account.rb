class Account < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :handle, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9_]+\z/, message: "can only contain letters, numbers, and underscores" }

  normalizes :handle, with: -> handle { handle.strip.downcase }
end
