class OrdersController < ApplicationController
  def index
    @orders = current_account.orders
  end

  def show; end
end
