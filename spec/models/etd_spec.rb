require 'bart/etd'
include Bart

describe 'An Etd initialized from a block of xml' do
  before do
    xml  = File.read('spec/files/etd.xml')
    @etd = Etd.new(xml)
  end

  it 'should have a destination' do
    @etd.destination.abbr.should == 'frmt'
  end

  it 'should have estimates' do
    @etd.estimates.size.should == 2
  end
end
