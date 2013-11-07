class Order < ActiveRecord::Base
  has_many   :order_items, dependent: :destroy
  has_many   :items, through: :order_items
  belongs_to :user

  def total
    #for each order_item
      #find quantity of item

      #find item price via item_id
      #return combined value of subtotals

    order_items.collect do |order_item|
      order_item.subtotal
    end.reduce(0,:+)

  end

end
