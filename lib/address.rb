
require_relative 'geocoding'

class Address
  attr_accessor :lat, :lng, :full_address

  def geocode
    search = Geocoder.search(full_address)
    location = search[0]

    if location.class.name == 'Geocoder::Result::GeocoderCa'
      self.lng = location.coordinates[1]
      self.lat = location.coordinates[0]
    end
  end

  def reverse_geocode
    search = Geocoder.search("#{lat},#{lng}")
    location = search[0]

    if location.class.name == 'Geocoder::Result::GeocoderCa'
      self.full_address = location.address
    end
  end

  def distance_between _coordinates
    Geocoder::Calculations.distance_between(coordinates, _coordinates)
  end

  def coordinates
    [lat,lng]
  end

  def miles_to location
    distance_between location.coordinates
  end

  def geocoded?
    !lat.nil? and !lng.nil?
  end

  def reverse_geocoded?
    !full_address.nil?
  end
end
