# Gstatsat
A Ruby Gem for calculating bearings of geostationary satellites

## Example
```
>> base_station = Gstatsat::BaseStation.new(latitude: 45.425533, longitude: -75.692482)
>> satellite = Gstatsat::Satellite.new(longitude: -98)
>> bearing = Gstatsat::SatelliteBearing.new(satellite: satellite, base_station: base_station)

>> bearing.azimuth
=> 209.9

>> bearing.elevation
=> 33.2

>> bearing.visible?
=> True
```
