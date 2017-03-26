ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'rack/test'
Dir.glob('./{config,lib,models,services,controllers}/init.rb').each do |file|
  require file
end

include Rack::Test::Methods

def app
  YoubikeAPI
end

def random_not_in_taipei_lat
  ([*-90..90] - [24, 25]).sample
end

def random_not_in_taipei_lng
  ([*-180..180] - [121]).sample
end
