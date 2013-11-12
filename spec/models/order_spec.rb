require 'spec_helper'

describe Order do

  it "finds the unsubmitted order" do
    user = User.create(:email => "dragons@example.com", :full_name => "yes sir",
                    :password => "foobar", :password_confirmation => "foobar")
    Order.create(:user_id => user.id, :status => "unsubmitted")
    Order.create(:user_id => user.id, :status => "gary")
    found_orders = Order.find_unsubmitted_order_for(user.id)
    found_orders.status.should eq('unsubmitted')
  end

  describe "checkout" do
    it "purchases unsubmitted order" do
      user = User.create(:email => "dragonsBalls@example.com", :full_name => "yes sir",
                    :password => "foobar", :password_confirmation => "foobar")
      order = Order.create!(:user_id => user.id, :status => "unsubmitted")
      order.purchase!
      expect(order.status).to eq('paid')
    end

    it "does not purchases non-unsubmitted order" do
      order = Order.create!(:user_id => 99, :status => "cancelled")
      order.purchase!
      expect(order.status).to eq('cancelled')
    end
  end

end
