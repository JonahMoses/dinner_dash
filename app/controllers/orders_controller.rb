class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :purchase, :confirmation]

  def index
    @orders = current_user.orders.order("created_at DESC")
  end

  def show
  end

  def new
    @order = current_user.orders.new
  end

  def edit
  end

  def create
    @order = current_user.orders.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to items_path }
    end
  end

  def purchase
    if @order.purchaseable?
      @order.purchase!
      session[:order_id] = nil
      redirect_to confirmation_order_path(@order)
    elsif @order.user.guest
      session[:last_order_page] = request.env['HTTP_REFERER'] || orders_path
      redirect_to sign_up_path, notice: "Please sign up to purchase your cart"
    else
      redirect_to @order, notice: "That order is #{@order.status} and can't be purchased.  Please purcahse your current cart."
    end
  end

  def confirmation
  end

  private
    def set_order
      @order = current_user.orders.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:user_id, :status)
    end
end
