class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :purchase]

  def index
    @orders = current_user.orders.all
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
    #check validity fo order
    # do stuff
    #redirect as necessary
  end

  private
    def set_order
      @order = current_user.orders.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:user_id, :status)
    end
end
