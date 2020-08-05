require 'rails_helper'

RSpec.describe 'Items', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let!(:order) { FactoryBot.create(:order) }

  describe '商品出品機能' do
    before do
      sign_in(user)
      visit new_item_path
    end
    context '出品が失敗した時' do
      it '送る値が空のため、メッセージの送信に失敗する' do
        expect do
          find("input[name='commit']").click
        end.to change { Item.count }.by(0)
        expect(current_path).to eq '/items'
      end
    end

    context '出品が成功した時' do
      it '出品に成功するとトップページへ遷移する' do
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
    it 'ログアウト状態でもorderが紐づいているitemにはSoldOutが付与されている' do
      visit root_path
      expect(current_path).to eq root_path
      within('.item-lists') do
        expect(page).to have_content order.item.price
        expect(page).to have_content order.item.name
        expect(page).to have_selector("img[src$='test_image.jpg']")
        expect(page).to have_css('.sold-out')
      end
    end
  end

  describe '商品詳細表示' do
    it '商品の詳細情報が表示されている' do
      visit item_path(order.item)
      expect(page).to have_content order.item.price
      expect(page).to have_content order.item.name
      expect(page).to have_selector("img[src$='test_image.jpg']")
      expect(page).to have_content order.item.description
      expect(page).to have_content order.item.user.nickname
      expect(page).to have_content order.item.genre.name
      expect(page).to have_content order.item.status.name
      expect(page).to have_content order.item.delivery_fee.name
      expect(page).to have_content order.item.prefecture.name
      expect(page).to have_content order.item.shipment.name
    end

    context 'ログアウト状態の時' do
      it '削除、編集ページへのリンクは表示されない' do
        visit item_path(order.item)
        expect(page).not_to have_content '商品の編集'
        expect(page).not_to have_content '削除'
      end
    end
    context 'ログイン状態の時' do
      let(:another_user) { FactoryBot.create(:user) }
      let(:item) { FactoryBot.create(:item) }

      it '出品したユーザーでないなら、削除、編集ページへのリンクは表示されない' do
        sign_in(another_user)
        visit item_path(order.item)
        expect(page).not_to have_content '商品の編集'
        expect(page).not_to have_content '削除'
      end

      it '出品したユーザーなら、削除、編集ページへのリンクが表示される' do
        sign_in(item.user)
        visit item_path(item)
        expect(page).to have_content '商品の編集'
        expect(page).to have_content '削除'
      end
    end
  end

  describe '商品編集機能' do
    let(:item) { FactoryBot.create(:item) }

    context '編集に失敗する時' do
      it '商品を出品したユーザーでないなら、トップページへ遷移する' do
        sign_in(order.user)
        visit edit_item_path(item)
        expect(current_path).to eq root_path
      end
      it '必要な値が空白なら、editページへ遷移してエラー内容が出力されている' do
        sign_in(item.user)
        visit edit_item_path(item)
        fill_in 'item_name', with: ''
        click_on '変更する'
        expect(current_path).to eq "/items/#{item.id}"
        expect(page).to have_content "Name can't be blank"
      end
      it 'すでに購入済みであるなら、トップページへ遷移する' do
        sign_in(order.item.user)
        visit edit_item_path(order.item)
        expect(current_path).to eq root_path
      end
    end

    context '編集に成功した時' do
      it '正しい情報なら内容を変更して、詳細ページへ遷移する' do
        sign_in(item.user)
        visit edit_item_path(item)
        fill_in 'item_name', with: '名前を変更します'
        expect  do
          find("input[name='commit']").click
        end.to change { Item.count }.by(0)
        expect(current_path).to eq item_path(item)
        expect(page).to have_no_content item.name
        expect(page).to have_content '名前を変更します'
      end
    end
  end

  describe '商品削除機能' do
    let(:item) { FactoryBot.create(:item) }
    context '削除に失敗した時' do
      it '出品者でないユーザーでは削除できず、トップページへ遷移する' do
        sign_in(user)
        visit item_path(item)
        expect(page).to have_no_link "削除", href: item_path(item)
      end
    end
    context '削除に成功した時' do
      it '出品者であるなら削除に成功し、トップページへ遷移する' do
        sign_in(item.user)
        visit item_path(item)
        expect  do
          find_link('削除', href: item_path(item)).click
        end.to change { Item.count }.by(-1)
        expect(current_path).to eq root_path
        expect(page).to have_no_content item.name
      end
    end
  end
end
