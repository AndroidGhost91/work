FactoryGirl.define do
  sequence(:email) { |n| "user#{n}@example.com" }

  factory :user do
    uid '12345'
    provider 'facebook'
    first_name 'Bob'
    last_name 'Jones'
    email
    password 'secret123'
    about 'user-about'
    website 'example.com'
    work 'work-location'
    education 'education'

    address
  end

  factory :event do
    title 'event-title'
    description 'event-description'
    start_at 1.day.from_now
    end_at 2.days.from_now

    association :eventable, factory: :user
  end

  factory :client, class: 'UserClient' do
    name 'Elvis Presley'
    website 'http://example.com'
    user
  end

  factory :group do
    sequence(:name) { |n| "group-#{n}" }
    description "group-description"
    association :owner, factory: :user
  end

  factory :slide do
    caption "Slide Caption"
  end

  factory :address do
    street '1 Infinite Loop'
    street2 '#1337'
    city 'Cupertino'
    state 'CA'
    zip_code 95014
    country 'US'
  end

  factory :post do
    content 'this is a post'
  end

  factory :region do
    title 'region-title'
    latitude 0
    longitude 0
    radius 10
  end
end

