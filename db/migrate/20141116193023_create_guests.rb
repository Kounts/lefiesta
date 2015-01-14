class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :name
      t.boolean :mandatory, :default=>false
      t.boolean :attending, :default=>false
      t.text :note
      t.references :event, index: true

      t.timestamps
    end
  end
end
