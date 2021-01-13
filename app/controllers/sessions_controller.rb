class SessionsController < ApplicationController
  def new; end

  def create
    @account = Account.find_by(email: params[:session][:email].downcase)
    if @account.try(:authenticate, params[:session][:password])
      if params[:session][:remember_me] == Settings.check_box
        remember(@account)
      else
        forget(@account)
      end
      flash[:success] = t "controller.sessions.create.success"
      log_in @account
      redirect_to root_path
    else
      flash.now[:danger] = t "controller.sessions.create.danger"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
