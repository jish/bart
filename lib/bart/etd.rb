require 'nokogiri'
require 'bart/station'

module Bart
  class Etd

    attr_reader :destination, :estimates

    def initialize(xml)
      document  = Nokogiri::XML.parse(xml)
      abbr      = document.at_css('abbreviation').text
      estimates = document.css('estimate')

      @destination = Station.new(abbr: abbr.upcase)
      @estimates   = estimates.inject([]) { |memo, i| memo << Estimate.new(i.to_s) }
    end

    def to_s
      "#{destination.name} #{estimates.map(&:minutes) * ', '}"
    end

  end
end
