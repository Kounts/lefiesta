class RenameShoppingItems < ActiveRecord::Migration
  def change
  	  rename_table :shopping_item, :shopping_items
  end
end
