class Author < ApplicationRecord
  has_many :books

  has_many :passive_relationship_author, class_name:  RelationshipAuthor.name, foreign_key: "author_f_id", dependent: :destroy
  has_many :user_following, through: :passive_relationship_author, source: :user_f

  before_save :name_nickname_downcase
  validates :name, presence: true, length: { maximum: 40 }
  validates :nickname, presence: true, length: { maximum: 40 }, uniqueness: { case_sensitive: false }
  validates :content, length: { maximum: 200 }

  def follow_author other_user 
    user_following << other_user
  end

  def unfollow_author other_user
    user_following.delete(other_user)
  end

  def author_following? other_user
    user_following.include?(other_user)
  end

  private
  def name_nickname_downcase
    self.name = name.downcase
    self.nickname = nickname.downcase
  end

  def update_book_author
    self.books.each(&:update_before_destroy_author)
  end
end
