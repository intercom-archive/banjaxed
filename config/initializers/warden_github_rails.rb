Warden::GitHub::Rails.setup do |config|
  config.add_scope :user,
    client_id: ENV['GITHUB_CLIENT_ID'],
    client_secret: ENV['GITHUB_CLIENT_SECRET'],
    scope: 'user:email,read:org'

  config.default_scope = :user
end

Warden::Manager.prepend_after_authentication do |user, _, _|
  User.create_or_update_from_github_user(user)
end
