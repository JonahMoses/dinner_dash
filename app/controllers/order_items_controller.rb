class OrderItemsController < ApplicationController
  before_action :set_order_item, only: [:show, :edit, :destroy]
  before_action :load_order, only: [:create, :update]

  # GET /order_items
  # GET /order_items.json
  def index
    @order_items = OrderItem.all
  end

  # GET /order_items/1
  # GET /order_items/1.json
  def show
  end

  # GET /order_items/new
  def new
    @order_item = OrderItem.new
  end

  # GET /order_items/1/edit
  def edit
  end

  # POST /order_items
  # POST /order_items.json
  def create
    @order_item = @order.order_items.find_or_initialize_by_item_id(params[:item_id])
    @order_item.quantity += 1
    respond_to do |format|
      if @order_item.save
        format.html { redirect_to orders_path, notice: 'Successfully added product to cart.' }
        format.json { render action: 'show', status: :created, location: @order_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @order_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /order_items/1
  # PATCH/PUT /order_items/1.json
  def update
    @order_item = @order.order_items.find_or_initialize_by_id(order_item_params)

    respond_to do |format|
      if params[:order_item][:quantity].to_i == 0
        @order_item.destroy
        format.html { redirect_to @order_item.order, notice: 'Item was removed from the order.' }
      elsif
        @order_item.update(order_item_params)
        format.html { redirect_to @order_item.order, notice: 'Order item was successuflly updated.' }
      else
        format.html { redirect_to @order_item }
      end
    end

  end

  # DELETE /order_items/1
  # DELETE /order_items/1.json
  def destroy
    @order_item.destroy
    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  private
    def set_order_item
      @order_item = OrderItem.find(params[:id])
    end

    def order_item_params
      params.require(:order_item).permit(:item_id, :order_id, :quantity)
    end

    def load_order
      unless current_user
        @user = User.new_guest
        if @user.save
          session[:user_id] = @user.id
        end
      end
      @order = Order.find_or_initialize_by_id(session[:order_id], status: "unsubmitted")
      @order.user_id = current_user.id
      if @order.new_record?
        @order.save!
        session[:order_id] = @order.id
      end
    end
end
