if ENV['TRAVIS']
  require 'coveralls'
  Coveralls.wear! 'rails'
else
  require 'simplecov'
  SimpleCov.start 'rails'
end
