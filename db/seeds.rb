# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name:  "User First",
             email: "manh@gmail.com",
             password:              "123123",
             password_confirmation: "123123",
             role: 2)

60.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  role = ((n+1)%5 == 0)? 1 : 0
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               role: role )
end

Publisher.create!(name: "Sách chưa xuất bản", address: "Khong dia chi", content: "")

10.times do |n|
  name = Faker::Name.name
  address = "#{n+1} street"
  content = "content #{n+1}"
  Publisher.create!(name: name, address: address, content: content)
end

Category.create!(name: "Sách không thể loại", content: "")

10.times do |n|
  name = Faker::Name.name
  content = "content #{n+1}"
  Category.create!(name: name, content: content)
end

Author.create!(name: "Tác giả ẩn danh", nickname: "Khong nickname", content: "")

10.times do |n|
  name = Faker::Name.name
  nickname = Faker::Name.name << "#{n+1}"
  content = "content #{n+1}"
  Author.create!(name: name, nickname: nickname, content: content)
end

10.times do |n|
  name = Faker::Name.name
  status = Faker::Name.name << "#{n+1}"
  content = "content #{n+1}"
  author_id = rand(1..10)
  category_id = rand(1..10)
  publisher_id = rand(1..10)
  Book.create!(name: name, status: status, content: content,
                  author_id: author_id, category_id: category_id,
                  publisher_id: publisher_id, number_of: 15, count: 15)
end

books = Book.order(:created_at).take(6)
10.times do
  content = Faker::Lorem.sentence(word_count: 3, supplemental: true)
  user_id = rand(1..10)
  books.each { |book| 
    book.comments.create!(content: content, user_id: user_id) 
    start_date = Time.now + rand(3..100).day
    end_date = start_date + rand(1..20).day
    confirm = rand(0..4)
    if confirm >= 2
      confirm_at = Time.now + 1.day
      book.borrows.create!(start_date: start_date, end_date: end_date, user_id: user_id, status: confirm, confirmed_at: confirm_at)
      book.update(number_of: book.number_of - 1)
    else
      book.borrows.create!(start_date: start_date, end_date: end_date, user_id: user_id, status: confirm)
      book.update(number_of: book.number_of - 1)
    end
  }
end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

authors = Author.all
author = authors.first
book = Book.first
following.each { |followed| 
  author.favorites.create(user_id: followed.id) 
  book.favorites.create(user_id: followed.id)
}
Author.all.each { |authorw| authorw.favorites.create(user_id: user.id) }
Book.all.each { |authorw| authorw.favorites.create(user_id: user.id) }
