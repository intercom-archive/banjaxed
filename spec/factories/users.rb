FactoryGirl.define do
  factory :user do
    sequence(:github_id) { |n| n }
    sequence(:github_username) { |n| "github_user_#{n}" }
  end
end
