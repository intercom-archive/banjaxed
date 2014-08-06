# This gem is only necessary when running on Heroku.
if Rails.env.production? && ENV.keys.any? { |key| key.match(/^HEROKU/) }
  require 'rails_12factor'
end
