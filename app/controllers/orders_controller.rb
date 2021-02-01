class OrdersController < ApplicationController
  before_action :load_order, only: :show

  def index
    @orders = current_account.orders
  end

  def show
    @order_details = @order.order_details.includes(:service)
  end

  private

  def load_order
    return if @order = Order.find_by(id: params[:id])

    flash[:danger] = t "controller.orders.show.danger"
    redirect_to root_path
  end
end
