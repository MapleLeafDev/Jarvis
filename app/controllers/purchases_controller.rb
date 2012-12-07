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

    respond_to do |format|
      format.js
    end
  end

  def index
    users = family
    @purchases = Array.new
    users.each do |user|
      Purchase.where(user_id: user.id).each do |purchase|
        @purchases << purchase
      end
    end

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
      @credits = user.credits.to_i + item.price.to_i
      user.credits = @credits
      user.save
    end
  end
end
