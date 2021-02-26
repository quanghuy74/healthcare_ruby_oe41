class AccountsController < ApplicationController
  load_and_authorize_resource
  
  before_action :load_staffs, only: :index
  before_action :permit_load_info, only: :show

  def show
    @reviews = @account.reviews.newest_first.paginate page: params[:page],
                per_page: Settings.account.staff.per_page
  end

  def index; end

  private
  def load_account
    return if @account = Account.find_by(id: params[:id])

    flash[:danger] = t "controller.accounts.load_account.error"
    redirect_to root_path
  end

  def load_staffs
    @staffs = Account.staff
    @staffs = if params[:term]
      @staffs.by_name(params[:term].strip)
    else
      @staffs
    end.newest_first.paginate page: params[:page],
                              per_page: Settings.account.staff.per_page
  end

  def permit_update
    return if current_account == @account

    flash[:danger] = t "error.permit"
    redirect_to root_path
  end

  def permit_load_info
    return if current_account == @account || @account.staff?

    flash[:danger] = t "error.permit"
    redirect_to root_path
  end
end
