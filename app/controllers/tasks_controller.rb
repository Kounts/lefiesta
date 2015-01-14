class TasksController < ApplicationController
	
  before_action :authenticate_user!
  
	def create
		@event = Event.find(params[:event_id])
		@task = @event.tasks.create(task_params)
		redirect_to event_path(@event, anchor: "task_list")
	end

	def destroy
		@event = Event.find(params[:event_id])
		@task = @event.tasks.find(params[:id])
		@task.destroy
		redirect_to event_path(@event, anchor: "task_list")
	end

	def set_done
		@event = Event.find(params[:event_id])
		@task = @event.tasks.find(params[:id])
		@task.done = !@task.done
		if @task.save
			redirect_to event_path(@event, anchor: "task_list")
		end;
	end;

	private 
	def task_params
		params.require(:task).permit(:name,:deadline,:done,:note,:user_id)
	end
end
