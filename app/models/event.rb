class Event < ActiveRecord::Base
	has_many :guests, dependent: :destroy
	has_many :contacts, dependent: :destroy
	has_many :shopping_items, dependent: :destroy
	has_many :tasks, dependent: :destroy
	validates :title, presence:true
end
