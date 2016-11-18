FactoryGirl.create_list(:book, 40)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')