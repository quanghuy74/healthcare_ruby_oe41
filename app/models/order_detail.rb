class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :service
  has_many :work_histories, dependent: :destroy
end
