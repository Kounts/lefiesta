class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :theme
      t.date :date
      t.string :location
      t.string :description

      t.timestamps
    end
  end
end
