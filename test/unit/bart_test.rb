require 'minitest/autorun'
require 'fakeweb'
require 'bart'

FakeWeb.allow_net_connect = false
class BartTest < MiniTest::Unit::TestCase

  def setup
    uri = 'http://api.bart.gov/api/stn.aspx?cmd=stns&key=MW9S-E7SL-26DU-VV8V'
    xml = File.read(File.expand_path('../../responses/stns.xml', __FILE__))
    FakeWeb.register_uri(:get, uri, :body => xml)
  end

  def test_should_be_able_to_instantiate_a_station_with_shortcut_notation
    station = Bart(abbr: :powl)
    assert_kind_of(Bart::Station, station)
  end

end
