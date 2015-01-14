class GuestsController < ApplicationController

	
  before_action :authenticate_user!

	def create
		@event = Event.find(params[:event_id])
		@guest = @event.guests.create(guest_params)
		redirect_to event_path(@event, anchor: "guest_list")
	end

	def destroy
@event = Event.find(params[:event_id])
@guest = @event.guests.find(params[:id])
@guest.destroy
redirect_to event_path(@event, anchor: "guest_list")
	end

	def set_attending
		@event = Event.find(params[:event_id])
		@guest = @event.guests.find(params[:id])
		@guest.attending = !@guest.attending
		if @guest.save
			redirect_to event_path(@event, anchor: "guest_list")
		end;
	end;

	private 
	def guest_params
		params.require(:guest).permit(:name,:mandatory,:attending,:note)
	end
end
