require 'minitest/autorun'
require 'gstatsat'

class GstatsatTest < Minitest::Test
  def setup
    @ottawa = {latitude: 45.425533, longitude: -75.692482}
    @sydney = {latitude: -33.865143, longitude: 151.209900}
    @i4f3 = {longitude: -98}
    @i4f1 = {longitude: 144}
  end

  def test_visible_bearing_from_ottawa
    base_station = Gstatsat::BaseStation.new(@ottawa)
    satellite = Gstatsat::Satellite.new(@i4f3)
    bearing = Gstatsat::SatelliteBearing.new(satellite: satellite, base_station: base_station)

    assert_equal 209.9, bearing.azimuth
    assert_equal 33.2, bearing.elevation
    assert bearing.visible?
  end

  def test_non_visible_bearing_from_ottawa
    base_station = Gstatsat::BaseStation.new(@ottawa)
    satellite = Gstatsat::Satellite.new(@i4f1)
    bearing = Gstatsat::SatelliteBearing.new(satellite: satellite, base_station: base_station)

    assert_equal 130.6, bearing.azimuth
    assert_equal -39.4, bearing.elevation
    refute bearing.visible?
  end

  def test_visible_bearing_from_sydney
    base_station = Gstatsat::BaseStation.new(@sydney)
    satellite = Gstatsat::Satellite.new(@i4f1)
    bearing = Gstatsat::SatelliteBearing.new(satellite: satellite, base_station: base_station)

    assert_equal 167.2, bearing.azimuth
    assert_equal 49.9, bearing.elevation
    assert bearing.visible?
  end

  def test_non_visible_bearing_from_sydney
    base_station = Gstatsat::BaseStation.new(@sydney)
    satellite = Gstatsat::Satellite.new(@i4f3)
    bearing = Gstatsat::SatelliteBearing.new(satellite: satellite, base_station: base_station)

    assert_equal 101.9, bearing.azimuth
    assert_equal -25.0, bearing.elevation
    refute bearing.visible?
  end

  def test_satellite_raises_error_on_string_longitude
    exception = assert_raises(KeyError) {
      Gstatsat::Satellite.new(longitude: 'string')
    }
    assert_equal( 'longitude is not numeric', exception.message )
  end

  def test_satellite_raises_error_on_invalid_longitude
    exception = assert_raises(KeyError) {
      Gstatsat::Satellite.new(longitude: 181)
    }
    assert_equal( 'invalid longitude value', exception.message )
  end

  def test_base_station_raises_error_on_string_longitude
    exception = assert_raises(KeyError) {
      Gstatsat::BaseStation.new(latitude: 0, longitude: 'string')
    }
    assert_equal( 'longitude is not numeric', exception.message )
  end

  def test_base_station_raises_error_on_invalid_longitude
    exception = assert_raises(KeyError) {
      Gstatsat::BaseStation.new(latitude: 0, longitude: 181)
    }
    assert_equal( 'invalid longitude value', exception.message )
  end

  def test_base_station_raises_error_on_string_latitude
    exception = assert_raises(KeyError) {
      Gstatsat::BaseStation.new(latitude: 'string', longitude: 0)
    }
    assert_equal( 'latitude is not numeric', exception.message )
  end

  def test_base_station_raises_error_on_invalid_longitude
    exception = assert_raises(KeyError) {
      Gstatsat::BaseStation.new(latitude: 91, longitude: 0)
    }
    assert_equal( 'invalid latitude value', exception.message )
  end
end
