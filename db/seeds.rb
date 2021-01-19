
Account.create!(full_name: "full_name",
  email: "huy25107@gmail.com",
  address: "address",
  date_of_birth: Time.now,
  gender: 1,
  card_id: "123123123",
  role: 1,
  status: 2,
  phone_number: "1231231231",
  password: "123123123",
  password_confirmation: "123123123",
  activated_at: Time.zone.now)
#generate account
30.times do |n|
  full_name = Faker::Name.name
  email = "example-#{n+1}@healthcare.org"
  password = "123123123"
  address = Faker::Address.street_address
  date_of_birth = Faker::Date.between(from: "1980-01-01", to: "2015-01-01")
  gender = Faker::Number.within(range: 0..1)
  card_id = Faker::Number.number(digits: 9)
  address = Faker::Address.street_address
  role = Faker::Number.within(range: 0..2)
  phone_number = Faker::Number.number(digits: 10)
  status = 2
  activated_at = Time.zone.now

  Account.create!(full_name: full_name,
               email: email,
               address: address,
               date_of_birth: date_of_birth,
               gender: gender,
               card_id: card_id,
               role: role,
               status: status,
               phone_number: phone_number,
               password: password,
               password_confirmation: password,
               activated_at: Time.zone.now)
end

#major
5.times do |n|
  Major.create!(
    name: Faker::FunnyName.name,
  )
end

#liscense
accounts = Account.all
accounts.each{ |account|
  License.create!(
    account_id: account.id,
    major_id: Faker::Number.within(range: 1..Major.count),
    level: Faker::FunnyName.name,
    workspace: Faker::Address.city,
    date_of_issue: Faker::Date.between(from: "2010-01-01", to: "2020-01-01"),
    place_of_issue: Faker::Address.city
  )
}

#service
5.times do |n|
  Service.create!(
    major_id: Faker::Number.within(range: 1..Major.count),
    name: Faker::FunnyName.name,
    image: "https://st.quantrimang.com/photos/image/2017/04/08/anh-dai-dien-FB-200.jpg",
    price: Faker::Number.within(range: 100..10000) ,
    description: Faker::Lorem.sentence(word_count: 10)
  )
end

#order
accounts.each { |account|
  5.times do |n|
    account.orders.create!(
      account_name: Faker::Name.name,
      phone: Faker::Number.number(digits: 10),
      address: Faker::Address.street_address,
      description: Faker::Lorem.sentence(word_count: 10),
      status: Faker::Number.within(range: 0..4),
      total_price: 0
    )
  end
}

#order_detail
orders = Order.all
services = Service.all
orders.each { |order|
  services.each  { |service|
    start_date = Faker::Date.between(from: "2019-01-01", to: "2021-01-01")
    end_date = Faker::Date.between(from: "2021-01-01", to: "2022-01-01")

    service.order_details.create!(
      order_id: order.id,
      start_date: start_date,
      end_date: end_date,
      into_money: service.price * (end_date - start_date)
    )
  }
}

#work_history
order_details = OrderDetail.all
order_details.each { |order_detail|

  order_detail.work_histories.create!(
    note: Faker::Lorem.sentence(word_count: 10),
  )
}

#review
accounts.each { |account|
  5.times do |n|
    account.reviews.create!(
      reviewer_id: Faker::Number.within(range: 1..Account.count),
      content: Faker::Lorem.sentence(word_count: 10),
      rate: Faker::Number.within(range: 1..5),
      reviewable_id:Faker::Number.within(range: 1..Account.count),
      reviewable_type: Account.name,
    )
  end
}

services = Service.all
services.each { |service|
  5.times do |n|
    service.reviews.create!(
      reviewer_id: Faker::Number.within(range: 1..Account.count),
      content: Faker::Lorem.sentence(word_count: 10),
      rate: Faker::Number.within(range: 1..5),
      reviewable_id: Faker::Number.within(range: 1..Service.count),
      reviewable_type: Service.name,
    )
  end
}
