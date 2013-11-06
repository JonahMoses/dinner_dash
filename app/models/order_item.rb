class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :item
  validates  :quantity, :numericality => { :greater_than => 0 }
  # validates  :active, inclusion: { in: 'true' || 'false' }

  def subtotal
    quantity*item.price
  end

  def active?
    item.active
  end

end
