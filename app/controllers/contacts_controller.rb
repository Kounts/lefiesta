class ContactsController < ApplicationController

	
  before_action :authenticate_user!

	def create
		@event = Event.find(params[:event_id])
		@contact = @event.contacts.create(contact_params)
		redirect_to event_path(@event)
	end

	def destroy
@event = Event.find(params[:event_id])
@contact = @event.contacts.find(params[:id])
@contact.destroy
redirect_to event_path(@event)
	end

	private 
	def contact_params
		params.require(:contact).permit(:name,:note,:web,:email,:phone)
	end
	
end