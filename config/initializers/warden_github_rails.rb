Warden::GitHub::Rails.setup do |config|
  config.add_scope :user,
    client_id: ENV['GITHUB_CLIENT_ID'],
    client_secret: ENV['GITHUB_CLIENT_SECRET'],
    scope: 'user:email,read:org'

  config.default_scope = :user
end
