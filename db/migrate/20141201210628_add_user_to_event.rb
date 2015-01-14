class AddUserToEvent < ActiveRecord::Migration
  def change
    change_table :events do |t|
      t.references :users
    end
  end
end