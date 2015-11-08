require_relative "../api/API"

class Event < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :local_time

  def self.get_local_time(event_params=nil)
    JSON.parse(
      API.get_local_time(
      remote_location: event_params[:remote_location],
      remote_time: event_params[:remote_time],
      local_location: event_params[:local_location]
      )
    )["results"]
  end

  def self.local_time_hash(local_time)
    {
      local_time: local_time
    }
  end

end
