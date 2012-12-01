class TasksController < ApplicationController
  before_filter :user_check

  def index
    @user = User.find(params[:user_id])
    date = Date.parse(Date.today.to_s).strftime("%A").downcase
    @todays = Task.where(daily: true, user_id: @user.id)
    @todays = @todays + Task.where(user_id: @user.id, date.intern => true)
    @this_weeks = Task.where(weekly: true, user_id: @user.id)
    @this_months = Task.where(monthly: true, user_id: @user.id)
    @time = Date.today.to_s

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end

  def chores
    @tasks = Task.all

    date = Date.parse(Date.today.to_s).strftime("%A").downcase
    @todays = Task.where(daily: true)
    @todays = @todays + Task.where(date.intern => true)
    @this_weeks = Task.where(weekly: true)
    @this_months = Task.where(monthly: true)
    @time = Date.today.to_s

    respond_to do |format|
      format.html { render :chores}
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.find(params[:id])
    @completions = Completion.where(task_id: @task.id).order("completed DESC").limit(5)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @task = Task.new
    @users = User.where(parent_id: current_user.id)
    @users << current_user

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @users = User.where(parent_id: current_user.id)
    @users << current_user
    @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(params[:task])

    if params[:task][:period] == nil
      @task.period = 0
    end

    if params[:task][:points] == ""
      @task.points = 0
    end

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Chore was successfully created.' }
        format.json { render json: @task, status: :created, location: @task }
      else
        format.html { render action: "new" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to @task, notice: 'Chore was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to user_tasks_path(@task.user) }
      format.json { head :no_content }
    end
  end
end
