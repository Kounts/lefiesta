class EventsController < ApplicationController


  before_action :authenticate_user!
  
def new
	@event = Event.new
	@users = User.all;
end

def index
	@events = Event.order(date: :asc).all;
	@past_events = Event.where("date < ?", Date.today);	
	@future_events = Event.where("date >= ?",Date.today);
end

def create
	@event = Event.new(event_params)
	@users = User.all;
	create_event = true;

	if (!event_params[:pinterest].present? || (event_params[:pinterest] =~ /(.*)pinterest\.com\/([^\/]*)\/([^\/]*)/).present?)

		@pinterest_user = event_params[:pinterest].match(/pinterest\.com\/([^\/]*)\/([^\/]*)/)[1]
		@pinterest_board = event_params[:pinterest].match(/pinterest\.com\/([^\/]*)\/([^\/]*)/)[2]
		@response =JSON.parse(open("http://api.pinterest.com/v3/pidgets/boards/"+@pinterest_user+"/"+@pinterest_board+"/pins/").read)

		if @response["status"]!="success"
			create_event= false
		end
	else
		create_event= false
	end;

	if !create_event || !@event.save
		render 'new'
	else		
		redirect_to @event
	end
end

def show 
	require 'open-uri'
	@event = Event.find(params[:id])

	if @event.pinterest.present?
		@pinterest_user = @event.pinterest.match(/pinterest\.com\/([^\/]*)\/([^\/]*)/)[1]
		@pinterest_board = @event.pinterest.match(/pinterest\.com\/([^\/]*)\/([^\/]*)/)[2]
		@response =JSON.parse(open("http://api.pinterest.com/v3/pidgets/boards/"+@pinterest_user+"/"+@pinterest_board+"/pins/").read)
		if @response["status"]=="success"
			@pins = @response["data"]["pins"]
		else
		@pins = Array.new
		end
	else
		@pins = Array.new
	end

	@guests = @event.guests.order("lower(name) asc")
	@tasks = @event.tasks.order("done, deadline")
	@attending_guest = Guest.where("event_id = ?",@event.id).where("attending = ?", true)
	@done_task = Task.where("event_id = ?",@event.id).where("done=?", true)
	@manager = User.find(@event.users_id)	
	@is_past = @event.date < Date.today
	@is_manager = @manager == current_user
end

def edit
	@event = Event.find(params[:id])
	end

	def update
@event = Event.find(params[:id])
if @event.update(event_params)
	redirect_to @event
else render 'edit'
end
	end
	
	def destroy
		@event = Event.find(params[:id])
@event.destroy

redirect_to events_path
	end

private
def event_params
	params.require(:event).permit(:title,:theme,:date,:location,:description,:users_id,:pinterest)
end
end