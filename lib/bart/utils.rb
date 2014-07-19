module Bart
  class Utils
    def self.build_query(params)
      raise("You must specify a command! Possible commands can be found in Bart::Utils") if params[:cmd].nil? or params[:cmd].empty?

      case params[:cmd]
      when 'bsa', 'count', 'elev'
        uri = '/api/bsa.aspx'
      when 'etd'
        uri = '/api/etd.aspx'
      when 'routeinfo', 'routes'
        uri = '/api/route.aspx'
      when 'arrive', 'depart', 'fare', 'holiday', 'load', 'routesched', 'scheds', 'special', 'stnsched'
        uri = '/api/sched.aspx'
      when 'stnaccess', 'stninfo', 'stns'
        uri = '/api/stn.aspx'
      end

      query_params = '?' + params.map { |key, value| [key, value] * '=' } * '&'
      query = uri + query_params
    end

    def self.ask_bart(params)
      query = Bart::Utils.build_query(params)
      bart_request = Net::HTTP::Get.new(query)

      response = Net::HTTP.start('api.bart.gov') do |http|
        http.request(bart_request)
      end
    end

    def self.parse_departures(xml)
      document = Nokogiri::XML.parse(xml)
      @document = document
      document.css('etd').inject([]) do |memo, i|
        memo << Etd.new(i.to_s)
      end
    end

    def self.parse_stations(xml)
      document = Nokogiri::XML.parse(xml)
      @document = document
      document.css('station').inject([]) do |memo, i|
        station_name           = i.at_css('name').text
        station_abbr           = i.at_css('abbr').text
        station_gtfs_latitude  = i.at_css('gtfs_latitude').text
        station_gtfs_longitude = i.at_css('gtfs_longitude').text
        station_address        = i.at_css('address').text
        station_city           = i.at_css('city').text
        station_county         = i.at_css('county').text
        station_state          = i.at_css('state').text
        station_zipcode        = i.at_css('zipcode').text

        station_data = {
          name: station_name,
          abbr: station_abbr,
          gtfs_latitude: station_gtfs_latitude,
          gtfs_longitude: station_gtfs_longitude,
          address: station_address,
          city: station_city,
          county: station_county,
          state: station_state,
          zipcode: station_zipcode
        }

        memo << station_data
      end
    end
  end
end
