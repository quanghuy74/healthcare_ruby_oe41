class Service < ApplicationRecord
  belongs_to :major
  has_many :oder_details, dependent: :destroy
  has_many :reviews, as: :reviewable, dependent: :destroy
end
