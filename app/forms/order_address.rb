class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number, :item_id, :user_id

  with_options presence: true do
    validates :postal_code, format: { with: CONSTANT::POSTAL_CODE_REGEX, messages: 'is invalid. Include hyphen(-)' }
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :city
    validates :house_number
    validates :phone_number, format: { with: CONSTANT::PHONE_NUMBER_REGEX, messages: 'is invalid. Exclude hyphen(-)' }
    validates :item_id
    validates :user_id
  end

  def save
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, house_number: house_number,
                   building_name: building_name, phone_number: phone_number, item_id: item_id)
    Order.create(user_id: user_id, item_id: item_id)
  end
end
