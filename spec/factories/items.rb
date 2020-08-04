FactoryBot.define do
  factory :item do
    name { Faker::Lorem.word }
    price { 1000 }
    description { Faker::Lorem.sentence }
    genre_id { 2 }
    status_id { 2 }
    delivery_fee_id { 2 }
    prefecture_id { 2 }
    shipment_id { 2 }
    image { Rack::Test::UploadedFile.new('public/images/test_image.jpg') }
    association :user
  end
end
