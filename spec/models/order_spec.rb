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

end
