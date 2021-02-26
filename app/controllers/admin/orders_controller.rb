class Admin::OrdersController < ApplicationController
  layout "admin"

  authorize_resource class: Admin::OrdersController

  before_action :load_order, only: :edit

  def index
    @orders = Order.all.get_by_status(params[:status].to_i)
                   .includes(:account, order_details: :service)
                   .newest_first
                   .paginate page: params[:page],
                             per_page: Settings.account.staff.per_page
  end

  def edit
    if @order.update_attribute :status, params[:status].to_i
      flash[:success] = t "notice.success"
    else
      flash[:success] = t "notice.error"
    end
    redirect_to admin_orders_path
  end

  private

  def load_order
    return if @order = Order.find_by(id: params[:id])

    flash[:danger] = t "admin.manage_order.order_not_found"
    redirect_to admin_orders_path
  end
end
