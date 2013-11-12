require 'spec_helper'

describe OrdersController do

  describe "checkout" do
    #move these tests into model tests and move the purchase logic into model
    #also
    it "purchases unsubmitted order" do
      order = Order.create!(:user_id => 99, :status => "unsubmitted")
      order.purchase
      expect(order.status).to eq('paid')
    end

    xit "does not purchases non-unsubmitted order" do

    end

    it "routes to /orders/:id/purchase" do
     expect(:post => "/orders/99/purchase").to route_to(
       :controller => "orders",
       :action => "purchase",
       :id => "99"
     )
    end
  end

  describe "logging out" do
    it "routes to /log_out" do
      expect(:post => "/log_out").to route_to(
        :controller => "sessions",
        :action => "destroy"
      )
    end
  end

end
