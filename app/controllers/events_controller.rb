class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    local_time = Event.get_local_time(event_params)
    @event = Event.create(
      event_params.merge(
        Event.local_time_hash(local_time)
      )
    )
    redirect_to @event
  end

  def show

  end

  private

  def event_params
    params.require(:event)
      .permit(:remote_location, :remote_time, :local_location)
  end

end
