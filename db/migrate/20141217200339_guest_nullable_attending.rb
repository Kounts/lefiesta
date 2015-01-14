class GuestNullableAttending < ActiveRecord::Migration
  def change
  	change_column :guests, :attending, :boolean
  end
end
