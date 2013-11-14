class DashboardController < ApplicationController
  def index
    @orders_by_status = Order.count(:group => "status")
    if params[:status]
      @filtered_orders = Order.where(:status => params[:status])
    else
      @filtered_orders = Order.order("created_at DESC")
    end
  end
end
