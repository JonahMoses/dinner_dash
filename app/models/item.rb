class Item < ActiveRecord::Base
  validates                 :title, :description, :price, presence: true
  validates                 :title, uniqueness: true
  validates                 :price, :numericality => { :greater_than => 0 }

  #validates_format_of       :price, :with => /\A\d{1,8}(\.\d{2})?\z/
  validates_numericality_of :price
  has_many                  :order_items
  has_many                  :item_categories
  has_many                  :categories, through: :item_categories
  has_many                  :orders, through: :order_items

  has_attached_file :image, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
    },
    :default_url => "default_image.png"

    process_in_background :image

  def price=(input)
    input.delete!("$")
    super
  end

  def category_names
    self.categories.collect do |c|
      c.name
    end.join(", ")
  end

  def add_categories(ids)
    self.categories = ids.map {|id| Category.find_by_id(id) }.compact
  end

end
