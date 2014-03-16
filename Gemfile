ruby '2.0.0'
source 'https://rubygems.org'

gem "rack", '~>1.0'
# gem "rack-rewrite", '~>1.0.0'
gem "thin"
gem "sinatra"
gem "sinatra-contrib"
gem "kramdown"
gem "haml"
gem "sass"
gem 'heroku'
gem 'compass'
gem "bootstrap-sass"
gem "foreman"
gem 'dotenv'
gem 'rails_12factor'

gem 'builder' # need this to construct TwiML

# let's make some phone calls
gem 'twilio-ruby'

group :test, :development do
  gem "sinatra-reloader"
  gem 'rspec'
  gem 'rack-test'
  gem 'guard-rspec'
  gem 'spork'
  gem 'jazz_hands'
end

group :test do
  gem 'growl', '1.0.3'
end
