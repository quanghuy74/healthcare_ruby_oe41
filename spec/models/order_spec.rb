require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "Associations" do
    it { should belong_to(:account) }
    it { should have_many(:order_details).dependent(:destroy) }
  end

  describe "Delegate" do
    it { should delegate_method(:full_name).to(:account).with_prefix true }
    it { should delegate_method(:address).to(:account).with_prefix true }
    it { should delegate_method(:phone_number).to(:account).with_prefix true }

  end

  describe "scopes" do
    it ".get_by_status returns all order by same status " do
      status = Order.statuses[:pending]
      expect(Order.get_by_status(status)).to match_array(Order.where(status: status))
    end
  end
end
