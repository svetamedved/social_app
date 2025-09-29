class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many_attached :images

  validates :content, presence: true, length: { maximum: 280 }
  validate :acceptable_images

  scope :recent, -> { order(created_at: :desc) }
  scope :by_user, ->(user) { where(user: user) }

  def comments_count
    comments.count
  end

  private

  def acceptable_images
    return unless images.attached?

    unless images.count <= 4
      errors.add(:images, "You can upload up to 4 images per post")
    end

    images.each do |image|
      unless image.content_type.in?(%w[image/jpeg image/jpg image/png image/gif image/webp])
        errors.add(:images, "Images must be JPEG, PNG, GIF, or WebP format")
      end

      unless image.byte_size <= 5.megabytes
        errors.add(:images, "Images must be smaller than 5MB")
      end
    end
  end
end
