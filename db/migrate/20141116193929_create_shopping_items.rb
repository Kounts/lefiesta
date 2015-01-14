class CreateShoppingItems < ActiveRecord::Migration
  def change
    create_table :shopping_items do |t|
      t.string :name
      t.integer :quantity
      t.boolean :bought, :default=>false
      t.text :note
      t.references :event, index: true

      t.timestamps
    end
  end
end
