class Item < ActiveRecord::Base
  validates :title, :description, :price, presence: true
  validates :title, uniqueness: true
  validates :price, :numericality => { :greater_than => 0 }
  validates_format_of :price, :with => /\A\d{1,8}(\.\d{2})?\z/
end
