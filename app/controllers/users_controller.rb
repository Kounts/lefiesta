class UsersController < ApplicationController
	
  before_action :authenticate_user!

	def show 
		@user = current_user
		@events = @user.events.all
		@all_tasks = @user.tasks.all
		@count_task = @all_tasks.count
		@tasks = @user.tasks.where(done: false).order(deadline: :asc)
		@count_notdone_task = @tasks.count
		@past_events = @events.where("date < ?", Date.today).order(date: :asc)
		@future_events = @events.where("date >= ?",Date.today).order(date: :asc)
	end
end