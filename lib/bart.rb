require 'bart/station'

def Bart(station_id)
  Bart::Station.new(abbr: station_id.to_s.upcase)
end
