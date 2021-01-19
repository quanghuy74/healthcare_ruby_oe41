class ServicesController < ApplicationController
  def index
    perpage = Settings.services.per_page
    @service = Service.newest_first.paginate(page: params[:page], per_page: perpage)
  end
end
