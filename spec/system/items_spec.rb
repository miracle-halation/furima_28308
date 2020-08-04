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

  describe '商品一覧表示' do
    before do
      @item = FactoryBot.create(:item, image: fixture_file_upload('public/images/test_image.jpg'))
      FactoryBot.create(:order, item: @item, user: @user)
    end

    it 'ログアウト状態でもorderが紐づいているitemにはSoldOutが付与されている' do
      visit root_path
      expect(current_path).to eq root_path
      within('.item-lists') do
        expect(page).to have_content @item.price
        expect(page).to have_content @item.name
        expect(page).to have_selector("img[src$='test_image.jpg']")
        expect(page).to have_css('.sold-out')
      end
    end
  end
end
