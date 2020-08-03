require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "#create" do
    before do
      @item = FactoryBot.build(:item)
      @item.image = fixture_file_upload("public/images/test_image.jpg")
    end

    it "全ての情報が正しく入力されていれば保存できる" do
      expect(@item).to be_valid
    end
    it "画像が空だと保存できない" do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end
    it "nameが空だと保存できない" do
      @item.name = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end
    it "descriptionが空だと保存できない" do
      @item.description = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Description can't be blank")
    end
    it "genre_idを選択していないと保存できない" do
      @item.genre_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Genre must be other than 1")
    end
    it "status_idを選択していないと保存できない" do
      @item.status_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Status must be other than 1")
    end
    it "delivery_fee_idを選択していないと保存できない" do
      @item.delivery_fee_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Delivery fee must be other than 1")
    end
    it "prefecture_idを選択していないと保存できない" do
      @item.prefecture_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Prefecture must be other than 1")
    end
    it "shipment_idを選択していないと保存できない" do
      @item.shipment_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Shipment must be other than 1")
    end
    it "priceが空だと保存できない" do
      @item.price = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
    end
    it "priceが300円以下だと保存できない" do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
    end
    it "priceが10000000円以上だと保存できない" do
      @item.price = 10000000
      @item.valid?
      expect(@item.errors.full_messages).to include("Price must be less than 10000000")
    end
    it "紐づいているユーザーがいないと保存できない" do
      @item.user = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("User must exist")
    end

  end
end
