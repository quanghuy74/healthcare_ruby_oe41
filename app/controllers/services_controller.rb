class ServicesController < ApplicationController
  before_action :load_service, only: :show

  def index
    @q = Service.ransack params[:q]
    @services = @q.result.newest_first.includes(:major)
                  .paginate page: params[:page],
                            per_page: Settings.account.staff.per_page
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
