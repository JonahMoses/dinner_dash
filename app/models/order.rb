class Order < ActiveRecord::Base
  has_many   :order_items, dependent: :destroy
  has_many   :items, through: :order_items
  belongs_to :user

  def total
    order_items.collect do |order_item|
      order_item.subtotal
    end.reduce(0,:+)
  end

  def self.find_unsubmitted_order_for(user_id)
    where(:status => 'unsubmitted').find_by_user_id(user_id)
  end

end
