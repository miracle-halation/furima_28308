class ItemsController < ApplicationController
  before_action :logged_in_user?, only: [:new, :create]
  def index
  end

  def new
    @item = Item.new
  end

  def create
    item = item.new(item_params)
    if item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item)
          .permit(:name, :price, :genre_id, :status_id,
                  :delivery_fee_id, :prefecture_id, :shipment_id)
          .merge(user_id: current_user.id)
  end

  def logged_in_user?
    return redirect_to new_user_session_path unless user_signed_in?
  end
end
