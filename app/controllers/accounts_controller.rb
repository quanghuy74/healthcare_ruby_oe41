class AccountsController < ApplicationController
  before_action :load_account, only: %i(show edit update)
  before_action :load_staffs, only: :index
  before_action :permit_update, only: %i(edit update)
  before_action :permit_load_info, only: :show

  def new
    @account = Account.new
  end

  def create
    @account = Account.new accounts_params
    if @account.save
      @account.send_activation_email
      flash[:info] = t "controller.accounts.create.info"
      redirect_to root_path
    else
      flash.now[:danger] = t "controller.accounts.create.danger"
      render :new
    end
  end

  def show
    @reviews = @account.reviews.newest_first.paginate page: params[:page],
                per_page: Settings.account.staff.per_page
  end

  def edit; end

  def update
    if @account.update update_account_params
      flash[:success] = t "controller.accounts.update.success"
      redirect_to @account
    else
      flash.now[:danger] = t "controller.accounts.update.fail"
      render :edit
    end
  end

  def index; end

  private

  def accounts_params
    params.require(:account).permit(:email, :password,
                                    :password_confirmation,
                                    :full_name, :address,
                                    :card_id, :phone_number,
                                    :date_of_birth)
  end

  def update_account_params
    params.require(:account).permit(:full_name, :card_id, :gender,
                                    :date_of_birth, :email,
                                    :address, :phone_number,
                                    :image)
  end

  def load_account
    return if @account = Account.find_by(id: params[:id])

    flash[:danger] = t "controller.accounts.load_account.error"
    redirect_to root_path
  end

  def load_staffs
    @staffs = Account.staff.sort_by_create_at.paginate page: params[:page],
                per_page: Settings.account.staff.per_page
  end

  def permit_update
    return if current_account?(@account)

    flash[:danger] = t "error.permit"
    redirect_to root_path
  end

  def permit_load_info
    return if current_account?(@account) || @account.staff?

    flash[:danger] = t "error.permit"
    redirect_to root_path
  end
end
