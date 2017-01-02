User.all.find_each do |user|
  15.times do
    FactoryGirl.create(:notification, to: user, from: user)
  end
  15.times do
    FactoryGirl.create(:notification, to: user, from: user, read: true)
  end
end

FactoryGirl.create_list(:book, 30)
(1..3).each do |index|
  user = FactoryGirl.create(
    :user, email: "#{ENV['DEV_EMAIL']}+#{index}@wolox.com.ar", password: '123123123'
  )
  FactoryGirl.create_list(:book_suggestion, 4, user: user)
  (1..3).each do |sub_index|
    book = Book.first(sub_index).last
    FactoryGirl.create(:wish, user: user, book: book)
    FactoryGirl.create(:rent, user: user, book: book,
      from: Time.current - (index * 4).days,
      to: Time.current - index.days
    )
  end
end

Book.all.find_each do |book|
  (1..10).each { |sub_index| FactoryGirl.create(:comment, book: book, user: User.all.sample) }
end
