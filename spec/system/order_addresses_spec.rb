require 'rails_helper'

RSpec.describe "OrderAddresses", type: :system do
  describe '商品購入機能' do
    let(:user) { FactoryBot.create(:user) }
    let(:item) { FactoryBot.create(:item) }

    context "失敗するとき" do
      let(:order){FactoryBot.create(:order)}
      it 'ログインしていないとログインページへ遷移する' do
        visit item_transactions_path(item)
        expect(current_path).to eq new_user_session_path
      end
      it '出品者がアクセスすると、トップページへ遷移する' do
        sign_in(item.user)
        visit item_transactions_path(item)
        expect(current_path).to eq root_path
      end
      it '購入済みの商品の購入ページへ行くとトップページに遷移する' do
        sign_in(order.item.user)
        visit item_transactions_path(order.item)
        expect(current_path).to eq root_path
      end
    end

    context "成功するとき" do
      it '正しく値を入力すると購入できて、トップページへ遷移する' do
        sign_in(user)
        visit item_transactions_path(item)
        fill_in "order_address[number]", with:"4242424242424242"
        fill_in "order_address[cvc]", with: "123"
        fill_in "order_address[exp_month]", with:"12"
        fill_in "order_address[exp_year]", with: "24"
        fill_in "order_address[postal_code]", with: "123-4567"
        select '北海道', from: 'order_address[prefecture_id]'
        fill_in "order_address[city]", with: "新宿"
        fill_in "order_address[house_number]", with: "1-1"
        fill_in "order_address[phone_number]", with: "09012345678"
        expect  do
          find("input[name='commit']").click
          sleep 1
        end.to change { Order.count }.by(1)
        expect(current_path).to eq root_path
      end
    end
  end
end
