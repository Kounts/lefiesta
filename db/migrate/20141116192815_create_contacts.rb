class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.text :note
      t.string :web
      t.string :email
      t.string :phone
      t.references :event, index: true

      t.timestamps
    end
  end
end
