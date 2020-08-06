require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '住所情報の保存' do
    let!(:order_address) { FactoryBot.build(:order_address) }

    it '全ての値が正しく入力されていれば保存できる' do
      expect(order_address).to be_valid
    end
    it 'postal_codeが空だと保存できない' do
      order_address.postal_code = nil
      order_address.valid?
      expect(order_address.errors.full_messages).to include("Postal code can't be blank")
    end
    it 'postal_codeにハイフンがないと保存できない' do
      order_address.postal_code = '1234567'
      order_address.valid?
      expect(order_address.errors.full_messages).to include('Postal code is invalid')
    end
    it 'prefectureを選択していないと保存できない' do
      order_address.prefecture_id = 1
      order_address.valid?
      expect(order_address.errors.full_messages).to include('Prefecture must be other than 1')
    end
    it 'cityが空だと保存できない' do
      order_address.city = nil
      order_address.valid?
      expect(order_address.errors.full_messages).to include("City can't be blank")
    end
    it 'house_numberが空だと保存できない' do
      order_address.house_number = nil
      order_address.valid?
      expect(order_address.errors.full_messages).to include("House number can't be blank")
    end
    it 'building_nameが空でも保存できる' do
      order_address.building_name = nil
      expect(order_address).to be_valid
    end
    it 'phone_numberが空だと保存できない' do
      order_address.phone_number = nil
      order_address.valid?
      expect(order_address.errors.full_messages).to include("Phone number can't be blank")
    end
    it 'phone_numberにハイフンがあると保存できない' do
      order_address.phone_number = '090-1234-5678'
      order_address.valid?
      expect(order_address.errors.full_messages).to include('Phone number is invalid')
    end
    it 'item_idがないと保存できない' do
      order_address.item_id = nil
      order_address.valid?
      expect(order_address.errors.full_messages).to include("Item can't be blank")
    end
    it 'user_idがないと保存できない' do
      order_address.user_id = nil
      order_address.valid?
      expect(order_address.errors.full_messages).to include("User can't be blank")
    end
  end
end
