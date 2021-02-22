require "faker"

FactoryBot.define do
  factory :order do |f|
    f.account_name {Faker::Name.name}
    f.phone {Faker::Number.number(digits: 10)}
    f.address {Faker::Address.street_address}
    f.description {Faker::Lorem.sentence(word_count: 10)}
    f.status {Faker::Number.within(range: 0..4)}
    f.total_price {0}
    f.created_at {Faker::Date.between(from: "2020-01-01", to: "2021-01-01")}
  end
end
