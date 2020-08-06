class TransactionsController < ApplicationController
  before_action :logged_in_user?, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :item_user?, only: [:index, :create]
  before_action :sold_out?, only: [:index, :create]

  def index
    @order = OrderAddress.new
  end

  def create
    @order = OrderAddress.new(order_params)
    if @order.valid?
      pay_params
      pay_item
      @order.save
      redirect_to root_path
    else
      render 'index'
    end
  end

  private

  def order_params
    params.require(:order_address)
          .permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number)
          .merge(item_id: @item.id, user_id: current_user.id)
  end

  def pay_params
    params.permit(:token)
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: pay_params[:token],
      currency: 'jpy'
    )
  end

  def logged_in_user?
    return redirect_to new_user_session_path unless user_signed_in?
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def item_user?
    return redirect_to root_path if current_user == @item.user
  end

  def sold_out?
    return redirect_to root_path unless @item.order.nil?
  end
end
