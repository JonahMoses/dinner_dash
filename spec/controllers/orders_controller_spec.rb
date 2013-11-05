require 'spec_helper'

describe OrdersController do
#http://localhost:3000/users/1/orders/1/order_items/
  describe "orders nested under users" do
    before :each do
      User.create!(:email => "user@example.com",
                 :full_name => "bo jangles",
                 :display_name => "bj",
                 :password => "foobarbaz",
                 :password_confirmation => "foobarbaz")
    end

    it "routes to users/1/orders" do
      expect(:get => "/users/1/orders").to route_to(
        :controller => "orders",
        :action => "index",
        :user_id => "1"
      )
    end

  end

end
