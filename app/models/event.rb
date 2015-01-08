class Event < ActiveRecord::Base
	has_many :guests, dependent: :destroy
	has_many :contacts, dependent: :destroy
	has_many :shopping_items, dependent: :destroy
	has_many :tasks, dependent: :destroy
  	belongs_to :user, :class_name => "User", :foreign_key => "users_id"
 	has_and_belongs_to_many :users, join_table: "event_users"
	validates :title, presence:true
	validates :date,presence: true

	accepts_nested_attributes_for :users

end
