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
        else
          format.html { render action: 'new' }
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
    @order_item = OrderItem.find_by(id: params[:id])
    respond_to do |format|
      if order_quantity_set_to_zero?
        @order_item.destroy
        format.html { redirect_to @order_item.order, notice: 'Item was removed from the order.' }
      else
        @order_item.update(quantity: params[:order_item][:quantity].to_i)
        format.html { redirect_to @order_item.order, notice: 'Order item was successuflly updated.' }
      end
    end
  end

  def order_quantity_set_to_zero?
    params[:order_item][:quantity].to_i == 0
  end

  def destroy
    @order_item.destroy
    respond_to do |format|
      format.html { redirect_to orders_url }
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
      #binding.pry
      save_order_and_set_session if @order.new_record?
    end

    def create_and_log_in_guest_user
      session[:user_id] = User.new_guest_user_id
    end

    def save_order_and_set_session
      #binding.pry
      @order.save!
      session[:order_id] = @order.id
    end

    def find_or_create_order
      existing_order = Order.find_unsubmitted_order_for(current_user.id)
      existing_order ? existing_order : get_order_and_assign_to_user
    end

    def get_order_and_assign_to_user
      order = Order.find_or_initialize_by_id(session[:order_id], status: "unsubmitted")
      #order = Order.find_or_initialize_by_id(session[:order_id], status: "unsubmitted")
      order.user_id = current_user.id
      order
    end

end
