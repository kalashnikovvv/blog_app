FactoryGirl.define do
  factory :article do
    sequence(:title) { |n| "Title #{n}" }
    sequence(:text) { |n| "Title #{n}" }
    publish_date { Date.today }
  end
end
