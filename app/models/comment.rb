class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_one_attached :image

  validates :content, presence: true, length: { maximum: 500 }
  validate :acceptable_image

  scope :recent, -> { order(created_at: :desc) }

  private

  def acceptable_image
    return unless image.attached?

    unless image.content_type.in?(%w[image/jpeg image/jpg image/png image/gif image/webp])
      errors.add(:image, "Image must be JPEG, PNG, GIF, or WebP format")
    end

    unless image.byte_size <= 5.megabytes
      errors.add(:image, "Image must be smaller than 5MB")
    end
  end
end
