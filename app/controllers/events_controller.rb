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

	def get_pins(url)		
		require 'open-uri'
		if !(url =~ /(.*)pinterest\.com\/([^\/]*)\/([^\/]*)/).present? 
			return nil
		end

		begin
		pinterest_user = url.match(/pinterest\.com\/([^\/]*)\/([^\/]*)/)[1]
		pinterest_board = url.match(/pinterest\.com\/([^\/]*)\/([^\/]*)/)[2]
		response =JSON.parse(open("http://api.pinterest.com/v3/pidgets/boards/"+pinterest_user+"/"+pinterest_board+"/pins/").read)

		if response["status"]!="success"
			return nil
		end
		rescue OpenURI::HTTPError => ex
			return nil
		rescue SocketError => se 
			return nil
		end

		return response
	end

	def create
		@event = Event.new(event_params)
		@users = User.all;
		create_event = true;

		@event.users_id = current_user.id
		@event.users << current_user

		if event_params[:pinterest].present? 
	 		if !get_pins(event_params[:pinterest])
				create_event= false
				@event.errors.add(:pinterest, " url is not correct")
			end
		end

		if !create_event || !@event.save
			render 'new'
		else		
			redirect_to user_path(current_user)
		end
	end

	def show 
		@event = Event.find(params[:id])
		@managers = @event.users	

		if !@managers.include?(current_user)
			redirect_to user_path(current_user), notice: "You have to be a manager to see this event."
		end;

		response = get_pins(@event.pinterest)

		if @event.pinterest.present? && response
			@pins = response["data"]["pins"]
		else
			@pins = Array.new
		end

		@guests = @event.guests.order("lower(name) asc")
		@tasks = @event.tasks.order("done, deadline")
		@shopping_items = @event.shopping_items.order("bought,lower(name)")
		@attending_guest = Guest.where("event_id = ?",@event.id).where("attending = ?", true)
		@done_task = Task.where("event_id = ?",@event.id).where("done=?", true)
		@managers = @event.users		
		@creator = @event.user
		@is_creator = @creator == current_user
		@is_past = @event.date < Date.today
		@task = @event.tasks.build
		@guest = @event.guests.build
		@shopping_item = @event.shopping_items.build
	end

	def edit

		@event = Event.find(params[:id])

		if !@event.users.include?(current_user)
			redirect_to user_path(current_user), notice: "You have to be a manager to edit this event."
		end;
	end

	def update
		@event = Event.find(params[:id])

		if !@event.users.include?(current_user)
			redirect_to user_path(current_user), notice: "You have to be a manager to update this event."
		end;
		update_event = true

		if event_params[:pinterest].present? 
	 		if !get_pins(event_params[:pinterest])
				update_event= false
				@event.errors.add(:pinterest, " url "+ event_params[:pinterest] + "is not correct")
			end
		end

		if !update_event || !@event.update(event_params)
			render 'edit'
		else		
			redirect_to @event
		end
	end
		
	def destroy
			@event = Event.find(params[:id])
		@event.destroy
		redirect_to user_path(current_user)
	end

	private
	def event_params
		params.require(:event).permit(:title,:theme,:date,:location,:description,:users_id,:pinterest,:user_ids =>[])
	end
end