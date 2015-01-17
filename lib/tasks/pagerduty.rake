namespace :pagerduty do
  desc 'Create a PagerDuty user in the database'
  task create_user: :environment do
    PagerDutyGithubUser = Struct.new(:id, :login, :name, :avatar_url)

    pagerduty_github_user = PagerDutyGithubUser.new(
      766800,
      'PagerDuty',
      '',
      'https://avatars.githubusercontent.com/u/766800?v=3'
    )

    User.create_or_update_from_github_user(pagerduty_github_user)
  end
end