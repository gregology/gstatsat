# Gstatsat
A Ruby Gem for calculating bearings of geostationary satellites

## Usage
```
irb(main):001:0> base_station = Gstatsat::BaseStation.new(latitude: 45.425533, longitude: -75.692482)
=> #<Gstatsat::BaseStation:0x007f9f00036460 @latitude=45.425533, @longitude=-75.692482>

irb(main):002:0> satellite = Gstatsat::Satellite.new(longitude: -98)
=> #<Gstatsat::Satellite:0x007f9f0003fee8 @longitude=-98>

irb(main):003:0> bearing = Gstatsat::SatelliteBearing.new(satellite: satellite, base_station: base_station)
=> #<Gstatsat::SatelliteBearing:0x007f9f0005c638 @satellite=#<Gstatsat::Satellite:0x007f9f0003fee8 @longitude=-98>, @base_station=#<Gstatsat::BaseStation:0x007f9f00036460 @latitude=45.425533, @longitude=-75.692482>, @elevation=33.2, @azimuth=209.9>

irb(main):004:0> bearing.azimuth
=> 209.9

irb(main):005:0> bearing.elevation
=> 33.2
```
