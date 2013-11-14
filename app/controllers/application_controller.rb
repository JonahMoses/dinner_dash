class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :order_items_count

  before_action :authorize

  delegate :allow?, to: :current_permission
  helper_method :allow?

  private

    def order_items_count
      if current_user
        current_cart = Order.find_unsubmitted_order_for(current_user.id)
        current_cart.items_count if current_cart
      else
        0
      end
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def current_permission
      @current_permission ||= Permission.new(current_user)
    end

    def authorize
      if !current_permission.allow?(params[:controller], params[:action])
        redirect_to root_url, alert: "Not authorized"
      end
    end

end
