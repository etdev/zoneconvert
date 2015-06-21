FactoryGirl.define do
  factory :user do
    email "test_user@example.com"
    password_digest "password"
  end
end
