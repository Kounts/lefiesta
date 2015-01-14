class ShoppingItemsController < ApplicationController

	
  before_action :authenticate_user!

	def create
		@event = Event.find(params[:event_id])
		@shopping_item = @event.shopping_items.create(shopping_item_params)
		redirect_to event_path(@event, anchor: "shopping_list")
	end

	def destroy
@event = Event.find(params[:event_id])
@shopping_item = @event.shopping_items.find(params[:id])
@shopping_item.destroy
redirect_to event_path(@event, anchor: "shopping_list")
	end	

	def set_bought
		@event = Event.find(params[:event_id])
		@shopping_item = @event.shopping_items.find(params[:id])
		@shopping_item.bought = !@shopping_item.bought
		if @shopping_item.save
			redirect_to event_path(@event, anchor: "shopping_list")
		end;
	end;

	private 
	def shopping_item_params
		params.require(:shopping_item).permit(:name,:quantity,:bought,:note)
	end
end
