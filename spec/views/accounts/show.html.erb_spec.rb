require "spec_helper"

RSpec.describe "accounts/show.html.erb", type: :view  do
  include SessionsHelper

  let!(:account) {FactoryBot.create(:account)}
  before do
    log_in account
  end
  
  it "displays account info correctly" do
    assign(:account, account)

    render 

    expect(account).to eq(Account.last)
  end
end
