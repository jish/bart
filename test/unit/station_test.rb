require 'minitest/autorun'
require 'fakeweb'
require 'bart/station'

FakeWeb.allow_net_connect = false

class StationTest < Minitest::Test

  include Bart

  def test_should_have_a_name
    station = Station.new(abbr: 'powl')
    assert_equal('Powell St. (SF)', station.name)
  end

  def test_should_initialize_with_an_uppercase_id
    station = Station.new(abbr: 'rich')
    assert_equal('Richmond', station.name)
  end

  def test_should_respond_to_abbr
    station = Station.new(abbr: 'rock')
    assert_equal('rock', station.abbr)
  end

  def test_asking_for_departures_should_trigger_a_fetch
    uri = 'http://api.bart.gov/api/etd.aspx?cmd=etd&orig=rock&key=MW9S-E7SL-26DU-VV8V'
    FakeWeb.register_uri(:get, uri, :body => 'hello')

    station = Station.new(abbr: 'rock')
    station.departures
    assert FakeWeb.last_request
  end

  def test_asking_for_departures_twice_should_not_trigger_a_fetch
    uri = 'http://api.bart.gov/api/etd.aspx?cmd=etd&orig=rock&key=MW9S-E7SL-26DU-VV8V'
    FakeWeb.register_uri(:get, uri, :body => 'hello')

    station = Station.new(abbr: 'rock')
    station.departures
    assert FakeWeb.last_request

    FakeWeb.clean_registry
    station.departures
  end

  def test_load_departures_with_query
    uri = 'http://api.bart.gov/api/etd.aspx?cmd=etd&orig=rock&key=MW9S-E7SL-26DU-VV8V&plat=1&dir=s'
    FakeWeb.register_uri(:get, uri, :body => 'hello')

    station = Station.new(abbr: 'rock')
    station.load_departures({:plat => 1, :dir => 's'})
    assert FakeWeb.last_request
  end

  def test_should_parse_xml
    uri = 'http://api.bart.gov/api/etd.aspx?cmd=etd&orig=rock&key=MW9S-E7SL-26DU-VV8V'
    xml = File.read(File.expand_path('../../responses/station.xml', __FILE__))
    FakeWeb.register_uri(:get, uri, :body => xml)

    station = Station.new(abbr: 'rock')
    station.departures

    assert_equal(2, station.departures.size)
  end

end
