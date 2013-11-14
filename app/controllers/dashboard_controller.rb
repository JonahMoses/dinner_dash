class DashboardController < ApplicationController
  def index
    @open_orders = Order.where(:status => "unsubmitted")
    @closed_orders = Order.where.not(:status => "unsubmitted")
    @orders_by_status = Order.count(:group => "status")
  end
end
