class ItemCategory < ActiveRecord::Base
  belongs_to :item
  belongs_to :category

  def all
    @categories = Categories.all
  end


end
