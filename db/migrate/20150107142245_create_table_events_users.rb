class CreateTableEventsUsers < ActiveRecord::Migration
  def change
    create_table :_events_users , :id => false do |t|
         t.references :event
         t.references :user
    end
  end
end
