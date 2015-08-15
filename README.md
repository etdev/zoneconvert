[![Code Climate](https://codeclimate.com/github/etdev/zoneconvert/badges/gpa.svg)](https://codeclimate.com/github/etdev/zoneconvert)

# ZoneConvert
A simple tool for converting a date/time from one time zone to another.  Answers the question "I want to remember to do X at 8:00PM Tokyo time, but what time is that for me, here in Los Angeles?"

# Use Cases
* See what time an event somewhere else will happen locally
* Coordinate meetings with people in other timezones
* Etc.

# Features
* Employs Turbolinks for a refreshless experience
* Sign up and store your events
* Export your events to Google calendar

# API
Requires both Google Maps and Mapquest API keys.  Store the following data in ``api/geocode.yml``

```yaml
data:
  - base_url_mq: "http://open.mapquestapi.com/geocoding/v1/address"
  - base_url_g: "https://maps.googleapis.com/maps/api/geocode/json"
  - api_key_mq: "<Your mapquest api key>"
  - api_key_g: "<Your google api key>"
```
