class Author < ApplicationRecord
  has_many :books
  before_save :name_nickname_downcase
  validates :name, presence: true, length: { maximum: 40 }
  validates :nickname, presence: true, length: { maximum: 40 }, uniqueness: { case_sensitive: false }
  validates :content, length: { maximum: 200 }
  private
  def name_nickname_downcase
    self.name = name.downcase
    self.nickname = nickname.downcase
  end
end
