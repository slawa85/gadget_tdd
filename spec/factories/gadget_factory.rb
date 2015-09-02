FactoryGirl.define do
  factory :gadget do
    sequence(:name) { |n| "Gadget #{n}" }
    sequence(:description) { |n| "Gadget description #{n}" }
    association :user
  end
end
