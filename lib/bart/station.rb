# http://api.bart.gov/docs/etd/etd.aspx uses abbr and abbreviation
# interchangeably. I'm settling on abbr to be both clear and concise.

require 'nokogiri'
require 'bart/etd'
require 'bart/station/list'

# CLEANUP
require 'net/http'
require 'bart/estimate'

module Bart

  class Station

    attr_reader :abbr

    # DEBUG
    attr_reader :document

    # OPTIMIZE If we have one station object, we don't need to initialize
    # new ones over and over again. We'll leave it alone for now, for
    # simplicity.
    def initialize(options = {})
      @abbr = options[:abbr] ? options[:abbr].downcase : nil
    end

    def self.from_xml(xml)
      document   = Nokogiri::XML.parse(xml)
      abbr       = document.css('abbr').text
      departures = document.css('etd')

      station = new(abbr)
      station.departures = departures.inject([]) do |memo, i|
        memo << Etd.new(i.to_s)
      end

      station
    end

    def name
      ID_TO_NAME[abbr]
    end

    def departures
      return @_departures if defined?(@_departures);
      @_departures = load_departures
    end

    # fetch
    def load_departures(query_params = {})
      params = {
        :cmd => 'etd',
        :orig => @abbr,
        :key => 'MW9S-E7SL-26DU-VV8V'
      }

      [:plat, :dir].each do |param|
        params[param] = query_params[param] if query_params.include?(param)
      end

      query_string = '?' + params.map { |key, value| [key, value] * '=' } * '&'
      ssan_etd = Net::HTTP::Get.new('/api/etd.aspx' + query_string )

      response = Net::HTTP.start('api.bart.gov') do |http|
        http.request(ssan_etd)
      end

      parse_departures(response.body)
    end

    def parse_departures(xml)
      document = Nokogiri::XML.parse(xml)
      @document = document
      document.css('etd').inject([]) do |memo, i|
        memo << Etd.new(i.to_s)
      end
    end

  end
end
