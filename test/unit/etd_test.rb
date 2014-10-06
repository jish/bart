require 'minitest/autorun'
require 'bart/etd'

class EtdTest < Minitest::Test

  include Bart

  response = File.expand_path('../../responses/etd.xml', __FILE__)
  RESPONSE = File.read(response)

  def test_should_have_a_destination
    etd = Etd.new(RESPONSE)
    assert_equal('frmt', etd.destination.abbr)
  end

  def test_should_have_estimates
    etd = Etd.new(RESPONSE)
    assert_equal(2, etd.estimates.size)
  end

  def test_should_to_s
    etd = Etd.new(RESPONSE)
    assert_equal('Fremont 0, 13', etd.to_s)
  end

end
