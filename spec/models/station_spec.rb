require 'bart/station'
include Bart

describe Station do

  it 'should have a name' do
    station = Station.new('ssan')
    station.name.should == 'South San Francisco'

    station = Station.new('powl')
    station.name.should == 'Powell St. (SF)'
  end

  it 'should initialize with an uppercase id' do
    station = Station.new('RICH')
    station.name.should == 'Richmond'
  end

  it "should provide it's abbreviation" do
    station = Station.new('rock')
    station.abbr.should == 'rock'
  end

end

describe "A Station initialized from a block of xml" do

  before do
    xml = File.read('spec/files/station.xml')
    @station = Station.from_xml(xml)
  end

  it 'should have departures' do
    @station.departures.size.should == 2
  end

end
