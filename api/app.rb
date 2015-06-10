require 'sinatra'
require 'sinatra/cross_origin'
require 'yaml'
require 'curb'
require 'json'
require 'sinatra/cross_origin'

enable :cross_origin
set :allow_origin, :any

class ZonesAPI < Sinatra::Base
  get '/' do
    headers \
          "Access-Control-Allow-Origin"   => "*"
    location = params["location"]
    load_data('geocode.yaml')
    url = build_url_mq(escape_HTML(location))
    response = process_json(get_response(url)["results"][0]["locations"][0])
    puts "Current time: #{Time.now.utc}"
    temp_time = get_timestamp(Time.now.utc)
    puts "Current timestamp (UTC): #{temp_time}"
    puts "Converted back from timestamp: #{Time.at(temp_time)}"
    time = coord_to_time(response[:lat], response[:lng], Time.now.utc)
    puts time.to_json
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
    puts "base_timestamp: #{base_timestamp}, dst_off: #{dst_off}, raw_off: #{raw_off}"
    total = base_timestamp + dst_off + raw_off
    { time: remove_utc(Time.at(total).utc.to_s) }

  end

  def load_data(filename)
    @data = symbolize_keys(YAML.load_file(filename))
    @base_url_mq = @data[:base_url_mq]
    @base_url_g = @data[:base_url_g]
    @api_key_mq = @data[:api_key_mq]
    @api_key_g = @data[:api_key_g]
  end

  def process_json(data)
   street = data["street"]
   adminArea6 = data["adminArea6"]
   adminArea6Type = data["adminArea6Type"]
   adminArea5 = data["adminArea5"]
   adminArea5Type = data["adminArea5Type"]
   adminArea4 = data["adminArea4"]
   adminArea4Type = data["adminArea4Type"]
   adminArea3 = data["adminArea3"]
   adminArea3Type = data["adminArea3Type"]
   adminArea2 = data["adminArea2"]
   adminArea2Type = data["adminArea2Type"]
   adminArea1 = data["adminArea1"]
   adminArea1Type = data["adminArea1Type"]
   postalCode = data["postalCode"]
   geocodeQualityCode = data["geocodeQualityCode"]
   geocodeQuality = data["geocodeQuality"]
   dragPoint = data["dragPoint"]
   sideOfStreet = data["sideOfStreet"]
   linkId = data["linkId"]
   unknownInput = data["unknownInput"]
   type = data["type"]
   lat = data["latLng"]["lat"]
   lng = data["latLng"]["lng"]
   disp_lat = data["displayLatLng"]["lat"]
   disp_lng = data["displayLatLng"]["lng"]

   return { street: street, adminArea6: adminArea6, adminArea6Type: adminArea6Type, adminArea5: adminArea5, adminArea5Type: adminArea5Type, adminArea4: adminArea4, adminArea4Type: adminArea4Type, adminArea3: adminArea3, adminArea3Type: adminArea3Type, adminArea2: adminArea2, adminArea2Type: adminArea2Type, adminArea1: adminArea1, adminArea1Type: adminArea1Type, postalCode: postalCode, geocodeQualityCode: geocodeQualityCode, geocodeQuality: geocodeQuality, dragPoint: dragPoint, sideOfStreet: sideOfStreet, linkId: linkId, unknownInput: unknownInput, type: type, lat: lat, lng: lng, disp_lat: disp_lat, disp_lng: disp_lng  }

  end

end

