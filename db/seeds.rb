User.all.find_each do |user|
  15.times do
    FactoryBot.create(:notification, to: user, from: user)
  end
  15.times do
    FactoryBot.create(:notification, to: user, from: user, read: true)
  end
end

User.create(email: 'testmail@wolox.com.ar', password: '123123123',
            password_confirmation: '123123123', first_name: 'Test',
            last_name: 'TestLastName', locale: 'es')

FactoryBot.create_list(:book, 30)
(1..3).each do |index|
  user = FactoryBot.create(
    :user, email: "#{Rails.application.credentials.dev_email}+#{index}@wolox.com.ar", password: '123123123'
  )
  FactoryBot.create_list(:book_suggestion, 4, user: user)
  (1..3).each do |sub_index|
    book = Book.first(sub_index).last
    FactoryBot.create(:wish, user: user, book: book)
    FactoryBot.create(:rent, user: user, book: book,
      from: Time.current - (index * 4).days,
      to: Time.current - index.days
    )
  end
end

Book.all.find_each do |book|
  (1..10).each { |sub_index| FactoryBot.create(:comment, book: book, user: User.all.sample) }
end
