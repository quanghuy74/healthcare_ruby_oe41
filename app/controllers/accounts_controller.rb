class AccountsController < ApplicationController
  before_action :load_account, only: %i(show edit update)
  before_action :correct_account, only: %i(edit update)


  def new
    @account = Account.new
  end

  def show; end

  def edit; end

  def create
    @account = Account.new update_account_params
    if @account.save
      flash[:success] = t "controller.accounts.create.succsess"
      log_in @account
      redirect_to root_path
    else
      flash.now[:danger] = t "controller.accounts.create.danger"
      render :new
    end
  end

  def update
    if @account.update accounts_params
      flash[:success] = t "controller.accounts.update.success"
      redirect_to @user
    else
      flash.now[:danger] = t "controller.accounts.update.fail"
      render :edit
    end
  end

  private

  def accounts_params
    params.require(:account).permit(:full_name, :card_id, :gender, 
                                    :date_of_birth, :email,
                                    :password, :password_confirmation,
                                    :address, :card_id, :phone_number)
  end

  def update_account_params
    params.require(:account).permit(:full_name, :card_id, :gender, 
                                    :date_of_birth, :email,
                                    :address, :phone_number,
                                    :image)
  end

  def load_account
    return if @account = Account.find_by(id: params[:id])

    flash[:error] = t "controller.accounts.load_account.error"
    redirect_to root_path
  end

  def correct_account
    return if current_account? @account

    flash[:danger] = t "user_edit.correct_user"
    redirect_to root_url
  end
end
