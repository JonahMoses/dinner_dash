class OrderItemsController < ApplicationController
  before_action :set_order_item, only: [:show, :edit, :destroy]
  before_action :load_order, only: [:create, :update]

  def index
    @order_items = OrderItem.all
  end

  def show
  end

  def new
    @order_item = OrderItem.new
  end

  def edit
  end

  def create
    @order_item = @order.order_items.find_or_initialize_by_item_id(params[:item_id])
    if @order_item.active?
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
    else
      redirect_to orders_path, notice: 'Item currently is not actively for sale.'
    end
  end

  # def not_active?(item)
  #   item[:active] == 'true'
  # end

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
      find_or_create_cart
    end

    def find_or_create_cart
      create_and_log_in_guest_user unless current_user
      @order = find_or_create_order
      save_order_and_set_session if @order.new_record?
    end

    def create_and_log_in_guest_user
      session[:user_id] = User.new_guest_user_id
    end

    def save_order_and_set_session
      @order.save!
      session[:order_id] = @order.id
    end

    def find_or_create_order
      order = Order.find_or_initialize_by_id(session[:order_id], status: "unsubmitted")
      order.user_id = current_user.id
      order
    end

end
