class RelationshipAuthor < ApplicationRecord
  belongs_to :author_f, class_name: Author.name
  belongs_to :user_f, class_name: User.name
  validates :author_f_id, presence: true
  validates :user_f_id, presence: true
end
