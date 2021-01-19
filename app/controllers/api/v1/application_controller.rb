class Api::V1::ApplicationController < ActionController::API
  attr_reader :current_account

  private

  def authenticate_request!
    return if account_id_in_token?

    @current_account = Account.find(auth_token["account_id"])
  rescue JWT::VerificationError, JWT::DecodeError
    render json: {errors: ["Not Authenticated"]}, status: :unauthorized
  end

  def authenticate_admin
    return if Account.find(auth_token["account_id"]).admin?

    render json: {errors: ["Not Authenticated"]}, status: :unauthorized
  end

  def http_token
    @http_token ||= if request.headers["Authorization"].present?
                      request.headers["Authorization"].split(" ").last
                    end
  end

  def auth_token
    @auth_token ||= JsonWebToken.decode http_token
  end

  def account_id_in_token?
    http_token && auth_token && auth_token[:account_id].to_i
  end
end
