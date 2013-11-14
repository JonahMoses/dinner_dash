class Order < ActiveRecord::Base
  has_many   :order_items, dependent: :destroy
  has_many   :items, through: :order_items
  belongs_to :user

  def total
    order_items.map(&:subtotal).reduce(:+)
  end

  def items_count
    order_items.map(&:quantity).reduce(:+)
  end

  def self.find_unsubmitted_order_for(user_id)
    where(:status => 'unsubmitted').find_by_user_id(user_id)
  end

  def purchaseable?
    status == "unsubmitted" && user && !user.guest
  end

  def purchase!
    return unless purchaseable?
    update_attributes(:status => "paid")
  end

end
