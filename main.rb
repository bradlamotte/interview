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
      a = [
        create_address(61.582195, -149.443512),
        create_address(44.775211, -68.774184),
        create_address(25.891297, -97.393349),
        create_address(45.787839, -108.502110),
        create_address(35.109937, -89.959983)
      ]
      a.each { |address| address.reverse_geocode }
      a
    end

    def create_address lat, lng
      address = Address.new
      address.lat = lat
      address.lng = lng
      address
    end
  end

  get '/' do
    erb :index, locals: { addresses: addresses }
  end
end
