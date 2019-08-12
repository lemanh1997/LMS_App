class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :book
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :content, presence: true, length: { maximum: 500 }
  validates :user_id, presence: true
  validates :book_id, presence: true
  validate :picture_size

  private
  def picture_size
    if picture.size > 10.megabytes
      errors.add(:picture, t(:text_error))
    end
  end
end
