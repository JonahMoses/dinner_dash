class ChangeItemTableName < ActiveRecord::Migration
  def change
    rename_table :items_categories, :item_categories
  end
end
