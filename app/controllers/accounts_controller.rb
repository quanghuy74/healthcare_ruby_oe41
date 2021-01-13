class AccountsController < ApplicationController
  before_action :load_account, only: :show

  def new
    @account = Account.new
  end

  def create
    @account = Account.new accounts_params
    if @account.save
      flash[:success] = t "controller.accounts.create.succsess"
      redirect_to @account
    else
      flash[:danger] = t "controller.accounts.create.danger"
      render :new
    end
  end

  def show; end

  def accounts_params
    params.require(:account).permit(:email, :password,
                                    :password_confirmation,
                                    :full_name, :address,
                                    :card_id, :phone_number)
  end

  private

  def load_account
    return if @account = Account.find_by(id: params[:id])

    flash[:error] = t "controller.accounts.load_account.error"
    redirect_to root_path
  end
end
