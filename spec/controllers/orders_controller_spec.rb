require 'spec_helper'

describe OrdersController do

  describe "checkout" do
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
