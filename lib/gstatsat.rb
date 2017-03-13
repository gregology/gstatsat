module Gstatsat
  class Satellite
    attr_accessor :longitude
    def initialize(params = {})
      validate(params)
      @longitude = params.fetch(:longitude)
    end

    private
      def validate(params)
        longitude = params.fetch(:longitude)
        raise KeyError, 'longitude is not numeric' unless longitude.is_a? Numeric
        raise KeyError, 'invalid longitude value' unless longitude >= -180 && longitude <= 180
      end
  end

  class BaseStation
    attr_accessor :latitude, :longitude
    def initialize(params = {})
      validate(params)
      @latitude = params.fetch(:latitude)
      @longitude = params.fetch(:longitude)
    end

    private
      def validate(params)
        longitude = params.fetch(:longitude)
        latitude = params.fetch(:latitude)
        raise KeyError, 'longitude is not numeric' unless longitude.is_a? Numeric
        raise KeyError, 'latitude is not numeric' unless latitude.is_a? Numeric
        raise KeyError, 'invalid longitude value' unless longitude >= -180 && longitude <= 180
        raise KeyError, 'invalid latitude value' unless latitude >= -90 && latitude <= 90
      end
  end

  class SatelliteBearing
    attr_accessor :azimuth, :elevation
    def initialize(params = {})
      validate(params)
      @satellite = params.fetch(:satellite)
      @base_station = params.fetch(:base_station)
      calculate_bearing
    end

    def visible?
      elevation > 0
    end

    private
      def calculate_bearing
        earths_radius = 6371
        satellite_height = 35786
        azimuthal_angle_rads = to_radians(@base_station.longitude - @satellite.longitude)
        base_station_latitude_rads = to_radians(@base_station.latitude)
        sigma = earths_radius.to_f / ( earths_radius + satellite_height )
        beta = Math.acos(Math.cos(base_station_latitude_rads) * Math.cos(azimuthal_angle_rads))

        @elevation = to_degrees(Math.atan((Math.cos(beta) - sigma) / Math.sin(beta))).round(1)
        @azimuth = to_degrees(Math::PI + Math::atan(Math::tan(azimuthal_angle_rads) / Math::sin(base_station_latitude_rads))).round(1)
      end

      def to_radians(degrees)
        degrees * Math::PI / 180
      end

      def to_degrees(radians)
        radians * 180 / Math::PI
      end

      def validate(params)
        raise KeyError, 'satellite is not Gstatsat::Satellite class' unless params.fetch(:satellite).is_a? Gstatsat::Satellite
        raise KeyError, 'base_station is not Gstatsat::BaseStation class' unless params.fetch(:base_station).is_a? Gstatsat::BaseStation
      end
  end
end
