require "faker"

FactoryBot.define do
  factory :account do |f|
    f.full_name {Faker::Name.name}
    f.email {Faker::Internet.email}
    f.address {Faker::Address.street_address}
    f.date_of_birth {Faker::Date.between(from: "1980-01-01", to: "2015-01-01")}
    f.card_id {Faker::Number.number(digits: 9)}
    f.role {Account.roles[:customer]}
    f.status {Account.statuses[:active]}
    f.phone_number {Faker::Number.number(digits: 10)}
    f.password {"123123123"}
    f.password_confirmation {"123123123"}
    f.activated_at {Faker::Date.between(from: "2020-01-01", to: "2021-01-01")}
  end
end
