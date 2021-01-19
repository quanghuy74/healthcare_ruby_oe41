module OrdersHelper
  def into_money order_detail
    count_day = count_day(order_detail)
    into_money = count_day * order_detail.service.price

    into_money
  end

  def total_money(carts)
    carts.reduce(0) { |sum, cart| sum + cart["into_money"] }
  end

  def count_day order_detail
    (order_detail.end_date - order_detail.start_date).to_i + 1
  end

  def number_to_currency(number)
    ActionController::Base.helpers.number_to_currency(number, unit: "$", separator: ",", delimiter: ".")
  end
end
