class Staff::WorkHistoriesController < ApplicationController
  layout "staff"

  authorize_resource class: Staff::WorkHistoriesController  
  before_action :load_order_detail, only: :update
  before_action :load_work_histories, only: :index

  def index; end

  def update
    order = @order_detail.order
    OrderDetail.transaction do
      begin
        @order_detail.finished!
        if order.order_details.received.blank?
          order.finished!
        elsif order.received?
          order.inprogress!
        end
        flash[:success] = t "notice.success"
      rescue
        flash[:danger] = t "notice.error"
      ensure
        redirect_to staff_my_received_order_path
      end
    end
  end

  private

  def load_order_detail
    return if @order_detail = OrderDetail.find_by(id: params[:id])

    flash[:danger] = t("notice.error")
    redirect_to staff_my_received_order_path
  end

  def load_work_histories
    @received_orders = current_account.received_orders
    @work_histories = OrderDetail.by_order_ids(@received_orders.ids)
                                 .includes(:service)
                                 .finished
                                 .newest_first
                                 .paginate page: params[:page],
                                    per_page: Settings.account.staff.per_page
  end
end
