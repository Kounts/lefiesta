class AddPinterestToEvents < ActiveRecord::Migration
  def change
    add_column :events, :pinterest, :string
  end
end
