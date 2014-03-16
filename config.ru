require 'rubygems'
require 'bundler'
Bundler.setup

require 'rack'
require 'thin'
require 'dotenv'
require 'twilio-ruby'

# get environment variables
Dotenv.load

# set up redis
require 'redis'
uri = URI.parse(ENV["REDISCLOUD_URL"])
Redis.current = $redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

require 'redis-objects'

$: << File.dirname(__FILE__)
require 'family-fusion'

run Sinatra::Application