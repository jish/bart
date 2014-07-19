# http://api.bart.gov/docs/etd/etd.aspx uses abbr and abbreviation
# interchangeably. I'm settling on abbr to be both clear and concise.

require 'nokogiri'
require 'bart/etd'
require 'bart/station/list'
require 'bart/utils'

# CLEANUP
require 'net/http'
require 'bart/estimate'

module Bart
  class Station
    attr_reader :abbr, :api_key, :stations, :load_first

    # DEBUG
    attr_reader :document

    # OPTIMIZE If we have one station object, we don't need to initialize
    # new ones over and over again. We'll leave it alone for now, for
    # simplicity.
    def initialize(options = {})
      @abbr       = options[:abbr]       ? options[:abbr]       : nil
      @api_key    = options[:api_key]    ? options[:api_key]    : 'MW9S-E7SL-26DU-VV8V'
      @stations   = options[:stations]   ? options[:stations]   : nil
      @load_first = options[:load_first] ? options[:load_first] : true

      @stations = self.load_stations if self.load_first
    end

    def station_set?
      return false if @abbr.nil?
      true
    end

    def self.from_xml(xml)
      document   = Nokogiri::XML.parse(xml)
      abbr       = document.css('abbr').text
      departures = document.css('etd')

      station = new(abbr)
      station.departures = departures.inject([]) do |memo, i|
        memo << Etd.new(i.to_s)
      end
    end

    def name
      ID_TO_NAME[abbr]
    end

    def departures
      return @_departures if defined?(@_departures);
      @_departures = load_departures
    end

    # fetch
    def load_departures
      fail("You must set the station before loading departures!") unless self.station_set?
      params = {
        cmd: 'etd',
        orig: @abbr,
        key: @api_key
      }

      response = Bart::Utils.ask_bart(params)

      Bart::Utils.parse_departures(response.body)
    end

    def load_stations
      params = {
        :cmd => 'stns',
        :key => @api_key
      }

      response = Bart::Utils.ask_bart(params)
      Bart::Utils.parse_stations(response.body)
    end
  end
end
