FactoryGirl.define do
  factory :incident do
    title "Something is wrong"
    description "We should investigate"
    severity 'high'
    status 'open'
    user
  end
end
