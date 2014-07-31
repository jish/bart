require 'minitest/autorun'
require 'bart'

class BartTest < MiniTest::Unit::TestCase

  def test_should_be_able_to_instantiate_a_station_with_shortcut_notation
    station = Bart(abbr: :powl)
    assert_kind_of(Bart::Station, station)
  end

end
