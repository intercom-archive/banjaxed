source 'https://rubygems.org'

gem 'rails', '4.1.8'
gem 'pg'

gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'bootstrap-sass', '~> 3.3.0'

gem 'warden-github-rails', '~> 1.1.0'
gem 'sentry-raven'

gem 'html-pipeline', require: 'html/pipeline'
gem 'github-markdown', '~> 0.5', require: false
gem 'sanitize', '~> 2.0', require: false
gem 'rinku', '~> 1.7', require: false

group :development do
  gem 'spring'
  gem 'puma'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.1.0'
  gem 'factory_girl_rails'
end

group :test do
  gem 'shoulda-matchers', require: false
  gem 'simplecov', require: false
  gem 'coveralls', require: false
end

group :production do
  gem 'rails_12factor', require: false
end
