class Api::V1::AccountsController < Api::V1::ApplicationController
  before_action :authenticate_request!, :authenticate_admin

  def index
    @account = Account.all
    render json: {
      status: true,
      data: ActiveModelSerializers::SerializableResource.new(@account)
    },
    status: :ok
  end

end
