
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

_NOTE: This is still beta software. All public APIs are subject to change_

### Testing

To run the tests run the `test` Rake task:

    $ rake test
