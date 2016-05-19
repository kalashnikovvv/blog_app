FactoryGirl.define do
  factory :comment do
    sequence(:text) { |n| "Text #{n}" }
  end
end
