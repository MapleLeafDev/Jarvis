class UsersController < ApplicationController
  before_filter :authorize, only: [:edit, :update]

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

    respond_to do |format|
      format.js
    end 
  end

  def index
    @users = family

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def show
    @user = User.find(params[:id])

    @todays = Array.new
    @time = Date.today.to_s

    date = Date.parse(@time).strftime("%A").downcase

    Task.where(daily: true, user_id: @user.id).each do |task|
      @todays << task
    end
    Task.where(user_id: @user.id, date.intern => true).each do |task|
      @todays << task
    end
    @this_weeks = Task.where(weekly: true, user_id: @user.id)
    @this_months = Task.where(monthly: true, user_id: @user.id)

    @all = Task.where(user_id: @user.id)

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

    if User.find_by_email(@user.email)
      redirect_to new_user_path, notice: "Email address already used" and return
    end

    if params[:user][:user_type] == "0"
      @user.user_type = 0
    else
      @user.user_type = 10
    end

    if current_user
      @user.email = nil
      @user.password = current_user.family.url
      @user.password_confirmation = current_user.family.url
    end

    @user.credits = 0
    respond_to do |format|
      if @user.save
        if !current_user
          session[:user_id] = @user.id
          format.html { redirect_to @user, notice: "Thank you for signing up!" }
        else
          family = Family.find_by_id(FamilyMember.find_by_user_id(current_user.id).family_id)

          if family
            FamilyMember.create(family_id: family.id, user_id: @user.id)
            format.html { redirect_to family_path(family), notice: 'Family member was added.' }
          end
        end
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = User.find(params[:id])
    
    @user.name = params[:user][:name]
    @user.email = params[:user][:email]

    if params[:user][:user_type] == "0"
      @user.user_type = 0
    else
      @user.user_type = 10
    end

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
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
      format.html { redirect_to root_url }
    end
  end
end
