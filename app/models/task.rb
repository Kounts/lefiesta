class Task < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  validates :name, presence:true
  validates :deadline, presence:true
  validates :event_id, presence:true
  validates :user_id, presence:true
end
