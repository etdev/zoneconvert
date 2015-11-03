require "sinatra"
require "sinatra/cross_origin"
require "yaml"
require "net/http"
require "open-uri"
require "json"
require "pry"

enable :cross_origin
set :allow_origin, :any

class ZonesAPI < Sinatra::Base
  get '/getLocalTime' do
    headers \
          "Access-Control-Allow-Origin"   => "*"

    DATA = load_data('geocode.yml')

    # get remote time as UNIX
    remote_time = read_in_time(params["remote_time"])
    remote_time_int = get_unix_timestamp(remote_time)

    # get lat, lng for remote and local locations
    remote_location = params["remote_location"].strip
    remote_lat, remote_lng = get_lat_lng(remote_location)

    local_location = params["local_location"]
    local_lat, local_lng = get_lat_lng(local_location)

    # get time zone offsets
    remote_offset = coord_to_offset(remote_lat, remote_lng)
    local_offset = coord_to_offset(local_lat, local_lng)

    offset_diff = remote_offset - local_offset
    local_time = parse_unix_timestamp(remote_time_int - offset_diff)
    {
      results: local_time.to_s
    }.to_json
  end

  def read_in_time(time_str)
    DateTime.strptime(time_str, time_format_str)
  end

  def time_format_str
    "%m/%d/%Y %l:%M %p"
  end

  def get_unix_timestamp(date_time)
    date_time.to_time.to_i
  end

  def parse_unix_timestamp(timestamp)
    Time.at(timestamp)
  end

  def get_lat_lng(location)
    url = build_url_mq(location)
    process_lat_lng(get_json_response(url)["results"][0]["locations"][0]).values
  end

  def symbolize_keys(my_hash)
    Hash[my_hash.map{|(k,v)| [k.to_sym,v]}]
  end

  def get_json_response(url)
    JSON.parse(Net::HTTP.get(URI(url)))
  end

  def escape_HTML(str)
    CGI.escape(str)
  end

  def build_url_mq(location)
    "#{DATA["base_url_mq"]}?key=#{DATA["api_key_mq"]}&location=#{location}"
  end

  def build_url_g(lat_lng, timestamp="1331161200")
    "#{DATA["base_url_g"]}?&location=#{lat_lng}&timestamp=#{timestamp}&key=#{DATA["api_key_g"]}"
  end

  def remove_utc(str)
    str[0..-4]
  end

  def coord_to_offset(lat, lng)
    lat_lng = "#{lat},#{lng}"
    url = build_url_g(lat_lng)
    response = symbolize_keys(get_json_response(url))
    dst_off = response.fetch(:dstOffset).to_i
    raw_off = response.fetch(:rawOffset).to_i
    dst_off + raw_off
  end

  def get_timestamp(time)
    time.to_i
  end

  def process_timestamp(base_timestamp, dst_off, raw_off)
    total = base_timestamp + dst_off + raw_off
    { time: remove_utc(Time.at(total).utc.to_s) }
  end

  def load_data(filename)
    YAML.load_file(filename).fetch("data").reduce({}, :merge)
  end

  def process_lat_lng(data)
    {
      lat: data["latLng"]["lat"],
      lng: data["latLng"]["lng"]
    }
  end

end

