class GuestNullableAttending2 < ActiveRecord::Migration
  def change
  	change_column :guests, :attending, :boolean, :default => nil
  end
end
