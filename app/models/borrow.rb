class Borrow < ApplicationRecord
  belongs_to :book
  belongs_to :user
  enum status: [:default, :denied, :accepted, :borrowed, :returned]

  default_scope -> { order(created_at: :desc) }
  validates :start_date, presence: true, date: { after_or_equal_to: Time.current.to_date, before_or_equal_to: :end_date}
  validates :end_date, presence: true, date: { after_or_equal_to: :start_date }
  validates :confirmed_at, date: { before_or_equal_to: :start_date, allow_blank: true }
  validates :user_id, presence: true
  validates :book_id, presence: true
  scope :check_borrow, -> (user_id, book_id) { where("user_id = ? AND book_id = ? AND (status != 4 && status != 1)", user_id, book_id) }
  scope :search_borrow, -> (name){ where("book_id in (select id from books where name like '%#{name}%') or user_id in (select id from users where name like '%#{name}%')") }
  scope :search_borrow_by_user, -> (name, user_id){ where("book_id in (select id from books where name like '%#{name}%') and user_id = ?", user_id) }

  def update_borrow status
    if status == Borrow.statuses.keys[2]
      update!(confirmed_at: Time.now)
    end
  end
end
