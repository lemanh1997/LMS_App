class Publisher < ApplicationRecord
  has_many :books
  before_save :name_address_downcase
  validates :name, presence: true, length: { maximum: 40 }, uniqueness: { case_sensitive: false }
  validates :address, presence: true, length: { maximum: 100 }
  validates :content, length: { maximum: 200 }
  def name_address_downcase
    self.name = name.downcase
    self.address = address.downcase 
  end

  def update_book_publisher
    self.books.each(&:update_before_destroy_publisher)
  end
end
