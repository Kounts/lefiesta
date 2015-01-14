class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.date :deadline
      t.boolean :done, :default=>false
      t.text :note
      t.references :event, index: true

      t.timestamps
    end
  end
end
