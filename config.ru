require 'rubygems'
require 'bundler'
Bundler.setup

require 'rack'
require 'thin'
require 'dotenv'
require 'twilio-ruby'

configure do
  # get environment variables
  Dotenv.load

  # set up redis
  require 'redis'
  uri = URI.parse(ENV["REDISCLOUD_URL"])
  $redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
end

$: << File.dirname(__FILE__)
require 'family-fusion'

run Sinatra::Application