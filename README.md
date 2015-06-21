# ZoneConvert
A simple tool for converting a date/time from one time zone to another

# Use Cases
* See what time an event somewhere else will happen in your timezone
* Coordinate meetings with people in other timezones
* Many others

# API
Store the following data in ``api/geocode.yaml``

```yaml
data:
  - base_url_mq: "http://open.mapquestapi.com/geocoding/v1/address"
  - base_url_g: "https://maps.googleapis.com/maps/api/geocode/json"
  - api_key_mq: "<Your mapquest api key>"
  - api_key_g: "<Your google api key>"
```

# Color Pallete
* text-muted: #0BADA7
* text-primary: #FFFFFF
* text-accent: #10FFF6

Primary options
![Colors1](http://i.imgur.com/Z4eOTL2.png)
Complementary options
![Colors2](http://i.imgur.com/vMCWjMO.png)
