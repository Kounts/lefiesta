class Event < ActiveRecord::Base
	has_many :guests, dependent: :destroy
	has_many :contacts, dependent: :destroy
	has_many :shopping_items, dependent: :destroy
	has_many :tasks, dependent: :destroy
  	has_one :user
	validates :title, presence:true
	validates :users_id,presence: true	
	validates :date,presence: true

end
