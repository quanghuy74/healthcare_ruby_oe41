class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :service

  delegate :status, to: :order, prefix: :order
  delegate :name, to: :service, prefix: :service

  scope :by_order_ids, ->(ids){where order_id: ids}
  enum status: {received: 0, finished: 1}
end
