class Order < ActiveRecord::Base
  has_many :order_items, dependent: :destroy

  def total
    # ?????
  end

end
