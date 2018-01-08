require 'sinatra/base'
require "sinatra/reloader"

Dir['./lib/*.rb'].each { |f| require f }

class Main < Sinatra::Base
  configure :development do
    enable :logging
    register Sinatra::Reloader
  end

  helpers do

  end

  get '/' do
    erb :index#address: address }
  end
end
