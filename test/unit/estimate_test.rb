require 'minitest/autorun'
require 'bart/estimate'

class EstimateTest < MiniTest::Unit::TestCase

  include Bart

  response = File.expand_path('../../responses/estimate.xml', __FILE__)
  RESPONSE = File.read(response)

  def test_should_respond_to_minutes
    estimate = Estimate.new(RESPONSE)
    assert_equal(21, estimate.minutes)
  end

  def test_should_respond_to_platform
    estimate = Estimate.new(RESPONSE)
    assert_equal(2, estimate.platform)
  end

  def test_should_respond_to_direction
    estimate = Estimate.new(RESPONSE)
    assert_equal('South', estimate.direction)
  end

  def test_should_respond_to_length
    estimate = Estimate.new(RESPONSE)
    assert_equal(5, estimate.length)
  end

  def test_should_respond_to_seconds
    estimate = Estimate.new(RESPONSE)
    assert_equal(1260, estimate.seconds)
  end

end
