class AccountActivationsController < ApplicationController
  def edit
    account = Account.find_by email: params[:email]
    if account && account.unactive? && account.authenticated?(:activation, params[:id])
      account.update_attribute :status, 2
      account.update_attribute :activated_at, Time.zone.now
      log_in account
      flash[:success] = t "controller.account_activation.edit.success"
    else
      flash[:danger] = t "controller.account_activation.edit.danger"
    end
    redirect_to root_path
  end
end
