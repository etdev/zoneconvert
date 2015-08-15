class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    @event = Event.get_local_time(event_params)
    redirect_to @event
  end

  def event_params
    params.require(:event)
      .permit(:remote_location, :remote_time, :local_location)
  end
end
