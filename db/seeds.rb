50.times do |n|
  name = Faker::Name.name
  email = "example#{n+1}@railstutorial.org"
  password = "12345678"
  address = Faker::Address.street_address
  date_of_birth = Faker::Date.between(from: "1980-01-01", to: "2015-01-01")
  gender = Faker::Number.within(range: 0..1)
  card_id = Faker::Number.number(digits: 9)
  address = Faker::Address.street_address
  avatar = "https://st.quantrimang.com/photos/image/2017/04/08/anh-dai-dien-FB-200.jpg" #image_tag("comment/avatar")
  role = Faker::Number.within(range: 0..2)
  status = 2


  Account.create!(full_name: name,
               email: email,
               address: address,
               date_of_birth: date_of_birth,
               gender: gender,
               card_id: card_id,
               avatar: avatar,
               role: role,
               status: status,
               password: "12345678",
               password_confirmation: "12345678")
end
