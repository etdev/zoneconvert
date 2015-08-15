class Event < ActiveRecord::Base

  def get_local_time(remote_location:, remote_time:, local_location:)
    API.get_local_time(
      remote_location: remote_location,
      remote_time: remote_time,
      local_location: local_location
    )
  end

end
