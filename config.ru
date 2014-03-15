require 'rubygems'
require 'bundler'
Bundler.setup
require 'rack'
require 'thin'

$: << File.dirname(__FILE__)
require 'family-fusion'

#use Rack::Static, :urls => ["/stylesheets", "/index.html", "/javascript"], :root => "public" 
# that used to include /images too...

run Sinatra::Application