require 'bart/station'

def Bart(station_id)
  Bart::Station.new(station_id.to_s)
end
