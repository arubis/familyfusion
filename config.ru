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
$redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

$: << File.dirname(__FILE__)
require 'family-fusion'

#use Rack::Static, :urls => ["/stylesheets", "/index.html", "/javascript"], :root => "public" 
# that used to include /images too...

run Sinatra::Application