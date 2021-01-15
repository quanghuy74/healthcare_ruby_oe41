class Order < ApplicationRecord
  belongs_to :account
  has_many :order_details, dependent: :destroy
  enum status: {
    pending: 0,
    approved: 1,
    received: 2,
    inprogress: 3,
    finished: 4
  }
end
