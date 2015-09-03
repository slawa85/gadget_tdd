FactoryGirl.define do
  factory :image do
    sequence(:image_content_type) { |n| "image/jpeg#{n}" }
    sequence(:image_file_name) { |n| "Image #{n}.jpeg" }
    sequence(:image_file_size) { |n| "256#{n}" }
    association :gadget
  end
end

