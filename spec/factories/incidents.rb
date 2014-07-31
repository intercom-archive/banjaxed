FactoryGirl.define do
  factory :incident do
    title "Something is wrong"
    description "We should investigate"
    severity 'medium'
  end
end
