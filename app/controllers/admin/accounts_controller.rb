class Admin::AccountsController < ApplicationController
  layout "admin"

  before_action :require_admin
  before_action :load_staffs, only: :index
  before_action :load_staff, only: %i(edit update destroy)
  before_action :load_customers, only: :index_customer
  before_action :load_customer, only: :block

  def index; end

  def index_customer; end

  def new
    @account = Account.new
    @account.build_license
  end

  def create
    @account = Account.new staff_params
    if @account.save && @account.update_columns(status: Account.statuses[:active],
                                                activated_at: Time.zone.now,
                                                role: Account.roles[:staff])
      flash[:success] = "notice.success"
      redirect_to admin_accounts_path
    else
      flash.now[:danger] = t "notice.error"
      render :new
    end
  end

  def update
    if @account.update update_staff_params
      flash[:success] = "notice.success"
      redirect_to admin_accounts_path
    else
      flash.now[:danger] = t "notice.error"
      render :edit
    end
  end

  def edit; end

  def destroy
    if @account.destroy
      flash[:success] = t "notice.success"
    else
      flash[:danger] = t "notice.error"
    end
    redirect_to admin_accounts_path
  end

  private

  def load_staffs
    @staffs = Account.staff.includes(license: :major)
                     .newest_first
                     .paginate page: params[:page],
                        per_page: Settings.account.staff.per_page
  end

  def load_customers
    @customers = Account.customer.newest_first
                        .paginate page: params[:page],
                          per_page: Settings.account.staff.per_page
  end

  def load_staff
    @account = Account.find_by id: params[:id]
    return if @account&.staff?

    flash[:danger] = t "notice.error"
    redirect_to admin_accounts_path
  end

  def load_customer
    @customer = Account.find_by id: params[:id]
    return if @customer

    flash[:danger] = t "notice.error"
    redirect_to admin_account_customer_path
  end

  def staff_params
    params.require(:account).permit(:full_name, :email,
                                    :address, :phone_number,:gender, :image,
                                    :password, :password_confirmation,
                                    license_attributes: [:major_id, :workspace])
  end

  def update_staff_params
    params.require(:account).permit(:full_name, :email,
                                    :address, :phone_number,:gender, :image,
                                    license_attributes: [:major_id, :workspace])
  end
end
