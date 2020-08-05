class ItemsController < ApplicationController
  before_action :logged_in_user?, only: [:new, :create]
  before_action :set_item, only: [:show, :edit, :update]
  before_action :item_user?, only: [:edit]
  before_action :sold_out?, only: [:edit, :update]
  def index
    @items = Item.includes(:order).with_attached_image.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render 'edit'
    end
  end

  private

  def item_params
    params.require(:item)
          .permit(:name, :price, :description, :genre_id, :status_id,
                  :delivery_fee_id, :prefecture_id, :shipment_id, :image)
          .merge(user_id: current_user.id)
  end

  def logged_in_user?
    return redirect_to new_user_session_path unless user_signed_in?
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def item_user?
    return redirect_to root_path unless current_user == @item.user
  end

  def sold_out?
    return redirect_to root_path unless @item.order.nil?
  end
end
