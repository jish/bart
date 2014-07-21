
A ruby wrapper around the BART API. [http://api.bart.gov/](http://api.bart.gov/)

## Usage

Create a new station object

    require 'bart/station'

    station = Bart::Station.new(abbr: 'ssan')
    station.name
    # => "South San Francisco"

And see when then next trains are supposed to arrive

    station.load_departures
    station.departures.map do |d|
      [d.destination.name, d.estimates.map { |e| e.minutes }]
    end
    # => [["Pittsburg/Bay Point", [5, 25, 50]], ["Millbrae", [5, 25, 46]]]

Output a list of upcoming departures:

    require 'bart'
    puts Bart(abbr: :powl).departures
    # San Francisco Int'l Airport 2, 22
    # Pittsburg/Bay Point 4, 19

By default, when you initialize a new instance of `Bart::Station`, it makes an API call
to BART to get a list of BART stations and their information. If you wish to cache this
information locally so you don't need to call the BART API everytime you initialize
`Bart::Station` you could do something like this:

    require 'bart/station'
    require 'redis'
    require 'json'

    # We first get a list of stations and then convert it to json.
    stations_json = JSON.dump(Bart::Station.new.stations)

    # Then we put the json in redis so we can recall it later
    redis = Redis.new
    redis.set("stations", stations_json)

    ################################################################

    require 'bart/station'
    require 'redis'
    require 'json'

    # First load the stations from redis
    redis = Redis.new
    stations = JSON.parse(redis.get("stations"))

    # Then we initialize the Bart::Station using that data:
    station = Bart::Station.new(stations: stations)

_NOTE: This is still beta software. All public APIs are subject to change_
