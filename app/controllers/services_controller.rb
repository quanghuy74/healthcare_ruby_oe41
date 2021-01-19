class ServicesController < ApplicationController
  def index
    perpage = Settings.services.per_page
<<<<<<< HEAD
    @service = Service.newest_first.paginate(page: params[:page], per_page: perpage)
=======
    @service = Service.all.paginate(page: params[:page], per_page: perpage)
  end

  def new; end

  def show
    @service = Service.find_by(id: params[:id])

    @reviews = @service.reviews.paginate page: params[:page],
        per_page: Settings.account.staff.per_page
>>>>>>> review service
  end
end
