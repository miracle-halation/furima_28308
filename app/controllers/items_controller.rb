class ItemsController < ApplicationController
  before_action :logged_in_user?, only: [:new, :create]
  def index
  end

  def new
    @item = Item.new()
  end

  def create
  end

  private
    def logged_in_user?
      return redirect_to new_user_session_path unless user_signed_in?
    end
end
