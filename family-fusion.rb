
require 'sinatra'
require 'sinatra/reloader' if development?

require 'dotenv'
require 'twilio-ruby'

require 'haml'
require 'kramdown'

# configure
set :haml, :format => :html5, :layout => true
   # n.b. :layout => true renders haml docs through layout.haml if it exists
   # and can be redirected to another symbol for a different layout
   # or "false" for none

# get environment variables
Dotenv.load

# set up twilio
ACCOUNT_SID = ENV['TWILIO_SID']
AUTH_TOKEN = ENV['TWILIO_TOKEN']
CALLER_ID = '+17139994373' # why yes I am hardcoding this
BASE_URL = 'http://familyfusion.herokuapp.com/'
@client = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN

# set up basic caching
#set :static_cache_control, [:public, :max_age => 300]
#before do
#  cache_control :public, :must_revalidate, :max_age => 300
#end

get '/' do
  # @call = @client.account.calls.create(
  #   from: '+17139994373',
  #   to: "+16173790642",
  #   url: 
  # )
  haml :main, locals: { title: "Hello, world!" }
end

post '/makecall' do
   # Use the Twilio REST API to initiate an outgoing call
  if !params['number']
    redirect_to '/error', 'msg' => 'Invalid phone number'
    return
  end
 
  # parameters sent to Twilio REST API
  data = {
    :from => CALLER_ID,
    :to => params['number'],
    :url => BASE_URL + '/reminder',
  }

  begin
    client = Twilio::REST::Client.new(ACCOUNT_SID, ACCOUNT_TOKEN)
    client.account.calls.create data
  rescue StandardError => bang
    redirect_to '/error', 'msg' => "Error #{bang}"
    return
  end
 
  redirect_to '/calling', 'msg' => "Calling #{params['number']}..."
end

get '/calling' do
  "Outgoing call! :: #{msg}, #{request.inspect}"
end

get '/error' do
  "Something went wrong: #{msg}, #{request.inspect}"
end


# get '/images/:image' do |image|
#   redirect 

# get '/bootstrap' do
#   haml :bootstrap, :layout => :layout_bootstrap
# end

# get '/s3/*' do
#   redirect 'https://(target server)/s3/' + params[:splat][0]
# end

# Redirect shared images to S3. Voila! Better clientside caching. Otherwise would choke on domain change.
# get '/images/:image' do |image|
#   redirect '/s3/images/' + image
# end