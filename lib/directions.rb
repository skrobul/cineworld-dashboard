require 'json'
require 'net/http'
require 'pp'

class GoogleDirections

  @@baseurl = "http://maps.googleapis.com/maps/api/directions/json"

  def self.get_directions(opts)
    raise "Please provide destination" unless opts[:destination]

    params = {
     origin: opts[:origin] || "Hanwell, London",
     destination: opts[:destination],
     sensor: 'false'
    }
    uri = URI(@@baseurl)
    uri.query = URI.encode_www_form(params)
    JSON.parse(Net::HTTP.get_response(uri).body)
  end

  def self.get_duration_and_distance(opts)
    dir = get_directions(opts)['routes'][0]['legs'][0] || :unknown
    return :unknown if dir == :unknown
    return {
      duration: dir['duration'],
      distance: dir['distance']
    }
  end

end


if $0 == __FILE__
  dir = GoogleDirections.get_duration_and_distance( :origin => "W7 3PX", :destination => "Cineworld Feltham")
  pp dir
end