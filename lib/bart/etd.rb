require 'nokogiri'
require 'bart/station'

module Bart
  class Etd

    attr_reader :destination, :estimates

    def initialize(xml)
      document  = Nokogiri::XML.parse(xml)
      abbr      = document.css('abbreviation').text
      estimates = document.css('estimate')

      @destination = Station.new(abbr)
      @estimates   = estimates.inject([]) { |memo, i| memo << Estimate.new(i.to_s) }
    end

  end
end
