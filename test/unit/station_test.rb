require 'minitest/autorun'
require 'bart/station'

class StationTest < MiniTest::Unit::TestCase

  include Bart

  def test_should_have_a_name
    station = Station.new('powl')
    assert_equal('Powell St. (SF)', station.name)
  end

  def test_should_initialize_with_an_uppercase_id
    station = Station.new('rich')
    assert_equal('Richmond', station.name)
  end

  def test_should_respond_to_abbr
    station = Station.new('rock')
    assert_equal('rock', station.abbr)
  end

  def test_a_station_initialized_from_xml_should_have_departures
    response = File.expand_path('../../responses/station.xml', __FILE__)
    response = File.read(response)
    station = Station.from_xml(response)
    assert_equal(2, station.departures.size)
  end

end
