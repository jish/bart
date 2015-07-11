require 'minitest/autorun'
require 'bart/estimate'

class EstimateTest < Minitest::Test

  include Bart

  response = File.expand_path('../../responses/estimate.xml', __FILE__)
  RESPONSE = File.read(response)

  def test_should_respond_to_minutes
    assert_equal(21, estimate.minutes)
  end

  def test_should_respond_to_platform
    assert_equal(2, estimate.platform)
  end

  def test_should_respond_to_direction
    assert_equal('South', estimate.direction)
  end

  def test_should_respond_to_length
    assert_equal(5, estimate.length)
  end

  def test_should_respond_to_seconds
    assert_equal(1260, estimate.seconds)
  end

  def test_should_respond_to_color
    assert_equal('ORANGE', estimate.color)
  end

  def test_should_respond_to_hexcolor
    assert_equal('#ff9933', estimate.hexcolor)
  end

  def test_should_respond_to_bikeflag
    assert_equal(true, estimate.bikeflag)
  end

  private

  def estimate
    Estimate.new(RESPONSE)
  end

end
