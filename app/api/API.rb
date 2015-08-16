require "net/http"
require "open-uri"

module API
  module_function
  def get_local_time(param_list=nil)
    Net::HTTP.get(URI("#{base_url}/getLocalTime?#{URI.encode_www_form(param_list)}"))
  end

  def base_url
    "http://api.zoneconvert.com"
    #"http://localhost:4001"
  end
end
