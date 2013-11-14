class DashboardController < ApplicationController
  def index
    @open_orders = Order.where(:status => "unsubmitted")
    @closed_orders = Order.where.not(:status => "unsubmitted")
  end
end
