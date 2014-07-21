require 'minitest/autorun'
require 'fakeweb'
require 'bart/station'

FakeWeb.allow_net_connect = false

class UtilsTest < MiniTest::Unit::TestCase

  include Bart

  def test_that_a_query_without_cmd_fails
    params = {}
    assert_raises(RuntimeError) { Utils.build_query(params) }
  end

  def basic_build_query_test(cmd, expected_aspx_filename)
    params = { cmd: cmd }
    query = Utils.build_query(params)
    assert_equal("/api/#{expected_aspx_filename}.aspx?cmd=#{cmd}", query)
  end

  def test_build_query_returns_expected_uris
    # bsa tests:
    %w[bsa count elev].each do |x|
      basic_build_query_test(x, 'bsa')
    end

    # etd tests
    basic_build_query_test('etd', 'etd')

    # route tests
    %w[routeinfo routes].each do |x|
      basic_build_query_test(x, 'route')
    end

    # sched tests
    %w[arrive depart fare holiday load routesched scheds special stnsched].each do |x|
      basic_build_query_test(x, 'sched')
    end

    # sched tests
    %w[stnaccess stninfo stns].each do |x|
      basic_build_query_test(x, 'stn')
    end
  end

end
