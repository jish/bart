require 'nokogiri'

module Bart
  class Estimate

    attr_reader :minutes, :platform, :direction, :length, :color, :hexcolor, :bikeflag

    def initialize(xml)
      document = Nokogiri::XML.parse(xml)

      @minutes   = document.css('minutes').text.to_i
      @platform  = document.css('platform').text.to_i
      @direction = document.css('direction').text
      @length    = document.css('length').text.to_i
      @color     = document.css('color').text
      @hexcolor  = document.css('hexcolor').text
      @bikeflag  = document.css('bikeflag').text.to_i == 1
    end

    def seconds
      @minutes * 60
    end

    def time
      Time.now + seconds
    end

  end
end
