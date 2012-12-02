class PurchasesController < ApplicationController

  def buy_item
    @purchase = Purchase.new

    user = User.find_by_id(params[:user])
    @item = Item.find_by_id(params[:item])

    @purchase.user_id = user.id
    @purchase.item_id = @item.id

    if @purchase.save
      @credits = user.credits.to_i - @item.price.to_i
      user.credits = @credits
      user.save

      @purchases = Purchase.where(item_id: @item.id).count
    end
  end

  def index
    @purchases = Purchase.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @purchases }
    end
  end

  def destroy
    @purchase = Purchase.find(params[:id])

    user = User.find_by_id(@purchase.user_id)
    item = Item.find_by_id(@purchase.item_id)

    if @purchase.destroy
      user.credits = user.credits.to_i + item.price.to_i
      user.save
    end
  end
end
