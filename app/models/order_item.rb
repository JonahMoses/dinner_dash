class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :item
  validates  :quantity, :numericality => { :greater_than => 0 }

  def subtotal
    quantity*item.price
  end

end
