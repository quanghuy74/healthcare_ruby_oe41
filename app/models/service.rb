class Service < ApplicationRecord
  belongs_to :major
  has_many :order_details, dependent: :destroy
  has_many :reviews, as: :reviewable, dependent: :destroy
end
