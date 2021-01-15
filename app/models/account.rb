class Account < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_one :license, dependent: :destroy
  has_many :reviews, as: :reviewable, dependent: :destroy
  has_many :rated_reviews, class_name: Review.name,
    foreign_key: :reviewer_id, dependent: :destroy
  enum role: {
    customer: 0,
    admin: 1,
    staff: 2
  }
  enum gender: {
    male: 0,
    female: 1
  }
  enum status: {
    unactive: 0,
    block: 1,
    active: 2
  }
end
