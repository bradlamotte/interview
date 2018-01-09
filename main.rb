require 'sinatra/base'
require "sinatra/reloader"

Dir['./lib/*.rb'].each { |f| require f }

class Main < Sinatra::Base
  configure :development do
    enable :logging
    register Sinatra::Reloader
  end

  helpers do
    def addresses
      [
        create_address(61.582195, -149.443512),
        create_address(44.775211, -68.774184),
        create_address(25.891297, -97.393349),
        create_address(45.787839, -108.502110),
        create_address(35.109937, -89.959983)
      ]
    end

    def create_address lat, lng
      address = Address.new
      address.lat = lat
      address.lng = lng
      address.reverse_geocode
      address.set_distance_between @wh.coordinates
      address
    end

    def white_house
      address = Address.new
      address.full_address = '1600 Pennsylvania Avenue NW Washington, D.C. 20500'
      address.geocode
      address
    end
  end

  get '/' do
    @wh = white_house
    erb :index, locals: { addresses: addresses }
  end
end
