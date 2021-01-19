class Staff::StaffsController < ApplicationController
  layout "staff"

  before_action :require_staff
  before_action :load_order, only: :update

  def index
    @orders = Order.approved.includes(order_details: :service)
                   .newest_first
                   .paginate page: params[:page],
                      per_page: Settings.account.staff.per_page
  end

  def update
    begin
      @order.update_columns(status: Order.statuses[:received],
                            staff_id: current_account.id)
      flash[:success] = t "notice.success"
    rescue
      flash[:danger] = t "notice.error"
    ensure
      redirect_to staff_staffs_path
    end
  end

  def my_received_order
    @orders = current_account.received_orders.not_finished
                             .includes(order_details: :service)
                             .newest_first
                             .paginate page: params[:page],
                                per_page: Settings.account.staff.per_page
  end

  private

  def load_order
    return if @order = Order.find_by(id: params[:id])

    flash[:danger] = t "admin.manage_order.order_not_found"
    redirect_to admin_orders_path
  end
end
