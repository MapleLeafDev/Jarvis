class UsersController < ApplicationController
  before_filter :authorize, except: [:new, :create]

  def show
    @user = User.find(params[:id])

    @as_needed = Hash.new
    @todays = Array.new
    temp = Array.new
    @all = Array.new
    @overdue = Array.new
    @time = Time.zone.today.to_s
    date = Date.parse(@time).strftime("%A").downcase

    if @user.user_type >= 10
      parents.each do |user|
        Task.where(daily: true, user_id: user.id).each do |task|
          @todays << task
        end
        Task.where(user_id: user.id, date.intern => true).each do |task|
          @todays << task
        end
        Task.where(weekly: true, user_id: user.id).each do |task|
          temp << task
        end
        Task.where(monthly: true, user_id: user.id).each do |task|
          temp << task
        end
        Task.where(user_id: user.id).each do |task|
          @all << task
        end
      end
    else
      Task.where(daily: true, user_id: @user.id).each do |task|
        @todays << task
      end
      Task.where(user_id: @user.id, date.intern => true).each do |task|
        @todays << task
      end
      Task.where(weekly: true, user_id: user.id).each do |task|
        temp << task
      end
      Task.where(monthly: true, user_id: user.id).each do |task|
        temp << task
      end
      @all = Task.where(user_id: @user.id)
    end

    temp.each do |task|
      if task.completions.count > 0
        completed = task.completions.last.completed
        @as_needed["#{completed}-#{task.id}"] = task
        last_done = (Date.today - Date.parse(completed)).to_i
        if (task.monthly && last_done > 30) || (task.weekly && last_done > 7)
          @overdue << task
        end
      else
        @as_needed["9999-99-99-#{task.id}"] = task
        completed = task.created_at.to_s
        last_done = (Date.today - Date.parse(completed)).to_i
        if (task.monthly && last_done > 30) || (task.weekly && last_done > 7)
          @overdue << task
        end
      end
    end

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

    @user.email = @user.email.downcase
    if @user.email != ""
      if User.find_by_email(@user.email)
        redirect_to new_user_path, notice: "Email address already used." and return
      end
    end

    if current_user
      @user.password = current_user.family.url
      @user.password_confirmation = current_user.family.url
      if params[:user][:user_type] == "0"
        @user.user_type = 0
      else
        @user.user_type = 10
      end
    else
      @user.user_type = 20
      if @user.email == ""
        redirect_to new_user_path, notice: "Email address required for new accounts." and return
      end
    end

    @user.credits = 0
    respond_to do |format|
      if @user.save
        if !current_user
          session[:user_id] = @user.id
          format.html { redirect_to @user, notice: "Thank you for signing up." }
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
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    @user.credits = params[:user][:credits]
    @user.time_zone = params[:user][:time_zone]

    if @user.user_type < 20
      if params[:user][:user_type] == "0"
        @user.user_type = 0
      else
        @user.user_type = 10
      end
    end

    respond_to do |format|
      if @user.save
        if current_user.family
          format.html { redirect_to family_path(current_user.family), notice: 'User was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { head :no_content }
        end
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
