class RemoveUsersReferenceInTask < ActiveRecord::Migration
  def change
  	remove_reference :tasks, :users    
    add_reference :tasks, :user
  end
end
