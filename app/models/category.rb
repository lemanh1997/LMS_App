class Category < ApplicationRecord
  has_many :books
  before_save :name_downcase
  validates :name, presence: true, length: { maximum: 40 }, uniqueness: { case_sensitive: false }
  validates :content, length: { maximum: 200 }
  def name_downcase
    self.name = name.downcase
  end

  def update_book_category
    self.books.each(&:update_before_destroy_category)
  end
end
