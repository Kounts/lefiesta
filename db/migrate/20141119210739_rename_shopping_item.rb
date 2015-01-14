class RenameShoppingItem < ActiveRecord::Migration
  def change
  	  rename_table :shopping_items, :shopping_item
  end
end
