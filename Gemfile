source 'https://rubygems.org'
ruby '2.3.1'

gem 'sinatra'
gem 'thin'
gem 'json'
gem 'rake'
gem 'sequel'
gem 'hirb'
gem 'tux'
gem 'http'

group :development do
  gem 'rerun'
end

group :test do
  gem 'minitest'
  gem 'rack'
  gem 'rack-test'
end

group :development, :test do
  gem 'sqlite3'
  gem 'config_env'
end

group :production do
  gem 'pg'
end
