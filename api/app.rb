require 'sinatra'
require 'sinatra/cross_origin'
require 'yaml'
require 'curb'
require 'json'
require 'pry'

enable :cross_origin
set :allow_origin, :any

# basic idea:
#   remote_time = 08/15/2015 10:41 AM
#   remote_time_int = standardized int rep.
#   remote_location = Tokyo, Japan
#   remote_offset = get_offset(remote_location)
#   local_offset = get_offset(local_location)
#   local_time_int = remote_time_int + diff(remote_off, local_off)
#   local_time = normalize(local_time_int)
#   args: ++remote_time++, ++local_location++, ++remote_location++

class ZonesAPI < Sinatra::Base
  get '/' do
    headers \
          "Access-Control-Allow-Origin"   => "*"
    location = params["location"]
    load_data('geocode.yml')
    url = build_url_mq(escape_HTML(location))
    response = process_json(get_response(url)["results"][0]["locations"][0])
    time = coord_to_time(response[:lat], response[:lng], Time.now.utc)
    time.to_json
  end

  def symbolize_keys(my_hash)
    Hash[my_hash.map{|(k,v)| [k.to_sym,v]}]
  end

  def get_response(url)
    curl = Curl::Easy.new(url)
    curl.perform
    JSON.parse(curl.body_str)
  end

  def escape_HTML(str)
    CGI.escape(str)
  end

  def build_url_mq(location)
    "#{@base_url_mq}?key=#{@api_key_mq}&location=#{location}"
  end

  def build_url_g(latlng, timestamp)
    "#{@base_url_g}?&location=#{latlng}&timestamp=#{timestamp}&#{@api_key_g}"
  end

  def remove_utc(str)
    str[0..-4]
  end

  def coord_to_time(lat, lng, base_time)
    latlng = "#{lat},#{lng}"
    base_timestamp = get_timestamp(base_time)
    url = build_url_g(latlng, get_timestamp(base_timestamp))
    response = symbolize_keys(get_response(url))
    dst_off = response[:dstOffset]
    raw_off = response[:rawOffset]
    process_timestamp(base_timestamp, dst_off, raw_off)
  end

  def get_timestamp(time)
    time.to_i
  end

  def process_timestamp(base_timestamp, dst_off, raw_off)
    total = base_timestamp + dst_off + raw_off
    { time: remove_utc(Time.at(total).utc.to_s) }
  end

  def load_data(filename)
    @data = YAML.load_file(filename).fetch("data").reduce({}, :merge)
    @base_url_mq = @data["base_url_mq"]
    @base_url_g = @data["base_url_g"]
    @api_key_mq = @data["api_key_mq"]
    @api_key_g = @data["api_key_g"]
  end

  def process_json(data)
    {
      lat: data["latLng"]["lat"],
      lng: data["latLng"]["lng"]
    }
  end

end

