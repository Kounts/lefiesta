class AddUserToTask < ActiveRecord::Migration
  def change
    change_table :tasks do |t|
      t.references :users
    end
  end
end
