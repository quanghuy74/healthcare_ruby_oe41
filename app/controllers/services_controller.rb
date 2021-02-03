class ServicesController < ApplicationController
  before_action :load_service, only: :show

  def index
    perpage = Settings.services.per_page
    @services = if params[:term]
      Service.by_name(params[:term].strip)
    else
      Service
    end.includes(:major, :reviews).newest_first.paginate page: params[:page],
                              per_page: perpage
  end

  def show
    @reviews = @service.reviews.newest_first.paginate page: params[:page],
        per_page: Settings.account.staff.per_page
  end

  private
  
  def load_service
    return if @service = Service.find_by(id: params[:id])

    flash[:danger] = t "controller.services.load.danger"
    redirect_to services_path
  end
end
