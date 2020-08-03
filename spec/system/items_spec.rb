require 'rails_helper'

RSpec.describe 'Items', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  describe '商品出品機能' do
    context '出品が失敗した時' do
      it '送る値が空のため、メッセージの送信に失敗する' do
        sign_in(@user)
        visit new_item_path
        expect do
          find("input[name='commit']").click
        end.to change { Item.count }.by(0)
        expect(current_path).to eq '/items'
      end
    end

    context '出品が成功した時' do
      it '出品に成功するとトップページへ遷移する' do
        sign_in(@user)
        visit new_item_path
        image_path = Rails.root.join('public/images/test_image.jpg')
        attach_file('item[image]', image_path)
        fill_in 'item_name', with: '商品名'
        fill_in 'item_description', with: '商品の説明'
        select 'レディース', from: 'item[genre_id]'
        select '新品・未使用', from: 'item[status_id]'
        select '着払い（購入者負担）', from: 'item[delivery_fee_id]'
        select '北海道', from: 'item[prefecture_id]'
        select '1~2日で発送', from: 'item[shipment_id]'
        fill_in 'item_price', with: 1000
        expect  do
          find("input[name='commit']").click
        end.to change { Item.count }.by(1)
        expect(current_path).to eq root_path
      end
    end
  end
end
