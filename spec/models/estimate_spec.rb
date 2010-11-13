require 'bart/estimate'
include Bart

describe 'An Estimate initialized by a block of xml' do

  before do
    xml = File.read('spec/files/estimate.xml')
    @estimate = Estimate.new(xml)
  end

  # Actual API attributes
  it 'should respond to minutes' do
    @estimate.minutes.should == 21
  end

  it 'should respond to platform' do
    @estimate.platform.should == 2
  end

  it 'should respond to direction' do
    @estimate.direction.should == 'South'
  end

  it 'should respond to length' do
    @estimate.length.should == 5
  end

  # Helper methods
  it 'should respond to seconds' do
    @estimate.seconds.should == 1260
  end

  # TODO write this test
  # it 'should respond to time' do
  #   @estimate.time.should == Time.now + 1260
  # end

end
