class EventsController < ApplicationController
def new
	@event = Event.new
	@users = User.all;
end

def index
	@events = Event.all;
	end

def create
	@event = Event.new(event_params)
	@users = User.all;

	if @event.save
	redirect_to @event
else
	render 'new'
end
	end

	def show 
		@event = Event.find(params[:id])
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
	params.require(:event).permit(:title,:theme,:date,:location,:description)
end
end