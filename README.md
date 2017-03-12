[![Gem](https://img.shields.io/gem/v/gstatsat.svg?style=flat)](http://rubygems.org/gems/gstatsat)
[![License](http://img.shields.io/badge/license-MIT-yellow.svg?style=flat)](https://github.com/gregology/gstatsat/blob/master/LICENSE)
[![Gregology](https://img.shields.io/badge/contact-Gregology-blue.svg?style=flat)](http://gregology.net/contact/)
[![Downloads](https://img.shields.io/gem/dt/gstatsat.svg?style=flat)](http://rubygems.org/gems/gstatsat)

# Gstatsat
A Ruby Gem for calculating bearings of geostationary satellites

## Installation

Add this line to your application's Gemfile:

``` ruby
gem 'gstatsat'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gstatsat

## Example
```  ruby
>> require 'gstatsat'
=> True

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

## Notes

The `visible?` method on `SatelliteBearing` is based on an elevation greater than 0. This simplified model assumes the earth is a perfect sphere and that the base station is at sea level. A satellites actual visibility may be affected by natural features such as mountains. It may also be possible to sight a satellite at a bearing less than 0 if the base station is at orbital altitudes.
