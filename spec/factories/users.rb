FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    family_name           { '山田' }
    family_name_reading   { 'ヤマダ' }
    first_name            { '太郎' }
    first_name_reading    { 'タロウ' }
    birthday              { Faker::Date.in_date_period }
  end
end
