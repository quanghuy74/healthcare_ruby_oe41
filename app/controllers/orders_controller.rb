class OrdersController < ApplicationController
  before_action :load_order, only: :show

  def index
    @orders = current_account.orders
  end

  def create 
    @order = Order.new(account_id: current_account.id,
                        status: Order.statuses[:pending],
                        total_price: total_money(@carts),
                        order_details_attributes: @carts)
    if @order.save
      session[:cart] = []
      flash[:success] = t "notice.success"
    else
      flash[:danger] = t "notice.error"
    end
    redirect_to services_path
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
