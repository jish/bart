require 'minitest/autorun'
require 'fakeweb'
require 'bart/station'

FakeWeb.allow_net_connect = false

class StationTest < MiniTest::Unit::TestCase

  include Bart

  def setup
    uri = 'http://api.bart.gov/api/stn.aspx?cmd=stns&key=MW9S-E7SL-26DU-VV8V'
    xml = File.read(File.expand_path('../../responses/stns.xml', __FILE__))
    FakeWeb.register_uri(:get, uri, :body => xml)
  end

  def test_should_have_a_name
    station = Station.new(abbr: 'powl')
    assert_equal('Powell St.', station.name)
  end

  def test_should_initialize_with_an_uppercase_abbr
    station = Station.new(abbr: 'rich')
    assert_equal('RICH', station.abbr)
  end

  def test_should_respond_to_abbr
    station = Station.new(abbr: 'ROCK')
    assert_equal('ROCK', station.abbr)
  end

  def test_should_respond_to_name
    station = Station.new(abbr: 'DUBL')
    assert_equal('Dublin/Pleasanton', station.name)
  end

  def setup_etd
    uri = 'http://api.bart.gov/api/etd.aspx?cmd=etd&orig=ROCK&key=MW9S-E7SL-26DU-VV8V'
    FakeWeb.register_uri(:get, uri, :body => 'hello')
  end

  def test_asking_for_departures_should_trigger_a_fetch
    setup_etd

    station = Station.new(abbr: 'rock')
    station.departures
    assert FakeWeb.last_request
  end

  def test_asking_for_departures_twice_should_not_trigger_a_fetch
    setup_etd

    station = Station.new(abbr: 'rock')
    station.departures
    assert FakeWeb.last_request

    FakeWeb.clean_registry
    station.departures
  end

  def test_should_parse_xml
    uri = 'http://api.bart.gov/api/etd.aspx?cmd=etd&orig=ROCK&key=MW9S-E7SL-26DU-VV8V'
    xml = File.read(File.expand_path('../../responses/station.xml', __FILE__))
    FakeWeb.register_uri(:get, uri, :body => xml)

    station = Station.new(abbr: 'rock')
    station.departures

    assert_equal(2, station.departures.size)
  end

end
