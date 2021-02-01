module OrdersHelper
  def into_money order_detail
    count_day = count_day(order_detail)
    into_money = count_day * order_detail.service.price

    into_money
  end

  def total_money order
    order.order_details.reduce(0) do |sum, o|
      sum + o.into_money
    end
  end

  def count_day order_detail
    (order_detail.end_date - order_detail.start_date).to_i
  end

  def number_to_currency(number)
    ActionController::Base.helpers.number_to_currency(number, unit: "$", separator: ",", delimiter: ".")
  end
end
