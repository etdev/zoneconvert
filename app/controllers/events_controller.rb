class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    begin
      local_time = Event.get_local_time(event_params)
    rescue
      redirect_back { flash[:warning] = "Failed to generate your event" } and return
    end

    if signed_in?
      @event = current_user.events.build(event_params.merge(Event.local_time_hash(local_time)))
    else
      @event = Event.new(event_params.merge(Event.local_time_hash(local_time)))
    end

    if @event.save
      redirect_to @event
    else
      redirect_back { flash[:warning] = "There was a problem creating your event." } and return
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  private

  def event_params
    params.require(:event)
      .permit(:remote_location, :remote_time, :local_location, :user_id)
  end

  def redirect_back
    yield
    redirect_to :back
  end

end
