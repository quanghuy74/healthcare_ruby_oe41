class CartsController < ApplicationController
  before_action :validate_date, :load_service, only: :create

  def index; end

  def show;end

  def create
    into_money = into_money_cart(@services.price, params[:start_date],
                                 params[:end_date])
    order_dettail = OrderDetail.new(service_id: params[:service_id],
                                    start_date: params[:start_date],
                                    end_date: params[:end_date],
                                    into_money: into_money)
                                    
    @carts << order_dettail
    redirect_to carts_path
  end

  def remove_service
    @carts.select!{|cart| cart["service_id"] != params[:service_id].to_i}
    redirect_to carts_path
  end

  private

  def load_service
    if @carts.select{|cart| cart["service_id"] == params[:service_id].to_i}.blank?
       @services = Service.find_by id: params[:service_id]
    else
      flash[:danger] = t "notice.service_exist"
      redirect_to services_path
    end
  end

  def validate_date
    if DateTime.parse(params[:start_date]) <= DateTime.parse(params[:end_date])
      return if DateTime.parse(params[:start_date]) >=  DateTime.parse(Time.now.strftime("%Y-%m-%d"))
      
    end
    flash[:danger] = t "notice.validate_date"
    redirect_to services_path
  end
end
