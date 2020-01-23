FactoryBot.define do
  factory :user do
    name { "#{Faker::Name.first_name}" }
    sequence(:email) { |n| "#{Faker::Name.first_name}#{n}@frog.com" }
    avatar { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/assets/avatar.jpg')) }
    password { '123123' }
  end
end
