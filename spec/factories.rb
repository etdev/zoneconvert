FactoryGirl.define do
  factory :user do
    sequence(:email) do |n|
      "test_user#{n}@example.com"
    end
    password_digest "password"
  end

  factory :event do
    user
    local_time "2015-11-08 09:28:00"
    remote_time "11/08/2015 11:28 PM"
    local_location "New York, NY"
    remote_location "Tokyo, Japan"
  end
end
