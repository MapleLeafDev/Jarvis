class UsersController < ApplicationController
  before_filter :user_check

  def award_credits
    @user = User.find_by_id(params[:user])
    if @user
      if params[:award] == "Award"
        @credits = @user.credits.to_i + params[:credits].to_i
        @user.credits = @credits
        @user.save
      elsif params[:remove] == "Remove"
        @credits = @user.credits.to_i - params[:credits].to_i
        @user.credits = @credits
        @user.save
      end
    end    
  end

  def index
    @users = User.where(parent_id: current_user.id)
    @users << current_user
    
    @todays = Array.new
    @this_weeks = Array.new
    @this_months = Array.new

    date = Date.parse(Date.today.to_s).strftime("%A").downcase

    @users.each do |user|
      Task.where(daily: true, user_id: user.id).each do |task|
        @todays << task
      end
      Task.where(user_id: user.id, date.intern => true).each do |task|
        @todays << task
      end
      Task.where(weekly: true, user_id: user.id).each do |task|
        @this_weeks << task
      end
      Task.where(monthly: true, user_id: user.id).each do |task|
        @this_months << task
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def show
    @user = User.find(params[:id])

    @todays = Task.where(daily: true, user_id: @user.id)

    @this_weeks = Task.where(weekly: true, user_id: @user.id)

    @this_months = Task.where(monthly: true, user_id: @user.id)

    @time = Date.today.to_s
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])

    if params[:user][:parent_id]
      @user.parent_id = User.find_by_facebook_id(params[:user][:parent_id]).id
    end

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = User.find(params[:id])

    @user.name = params[:user][:name]

    if params[:user][:parent_id]
      @user.parent_id = User.find_by_facebook_id(params[:user][:parent_id]).id
    end

    if params[:user][:thumbnail]
      @user.thumbnail = params[:user][:thumbnail]
    end

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
