
require 'sinatra'

configure do
  require 'haml'
  require 'kramdown'
  require 'sinatra/reloader' if development?

  # enable sessions
  enable :sessions
  set :haml, :format => :html5, :layout => true

  # set up twilio
  ACCOUNT_SID = ENV['TWILIO_SID']
  AUTH_TOKEN = ENV['TWILIO_TOKEN']
  CALLER_ID = '+17139994373' # why yes I am hardcoding this
  BASE_URL = 'http://familyfusion.herokuapp.com/'
end

# set up basic caching
#set :static_cache_control, [:public, :max_age => 300]
#before do
#  cache_control :public, :must_revalidate, :max_age => 300
#end

get '/' do
  haml :main
end

post '/call/?' do
   # Use the Twilio REST API to initiate an outgoing call
  if !params['number']
    redirect to('/error'), 'Invalid phone number'
    return
  end
 
  # parameters sent to Twilio REST API
  data = {
    :from => CALLER_ID,
    :to => params['number'],
    :url => BASE_URL + 'reminder'
  }

  begin
    client = Twilio::REST::Client.new(ACCOUNT_SID, AUTH_TOKEN)
    client.account.calls.create data
  rescue StandardError => bang
    redirect to('/error'), "Error #{bang}"
    return
  end
 
  redirect to('/calling'), "Calling #{params['number']}..."
end

get '/calling/?' do
  "Outgoing call! ::  #{request.inspect}"
end

get '/error/?' do
  "Something went wrong: #{request.inspect}"
end

post '/reminder/?' do
  # build up a response
  response = Twilio::TwiML::Response.new do |r|
    r.Say "It's good to call your mother. Please wait to connect.", :voice => 'alice'
    r.Dial '+16175002301'
    # r.Dial :callerId => '+14159992222' do |d|
    #   d.Client 'jenny'
    # end
  end

  # print the result
  puts response.text
  response.text
end

# get '/images/:image' do |image|
#   redirect 

# get '/s3/*' do
#   redirect 'https://(target server)/s3/' + params[:splat][0]
# end

# Redirect shared images to S3. Voila! Better clientside caching. Otherwise would choke on domain change.
# get '/images/:image' do |image|
#   redirect '/s3/images/' + image
# end