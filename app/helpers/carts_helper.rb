module CartsHelper
  def into_money_cart(price, start_date, end_date)
    price * (DateTime.parse(end_date)  - DateTime.parse(start_date)+1).to_i
  end
end
