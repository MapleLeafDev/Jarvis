class TasksController < ApplicationController
  before_filter :user_check

  def show
    @task = Task.find(params[:id])
    @completions = Completion.where(task_id: @task.id).order("completed DESC").limit(5)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task }
    end
  end

  def new
    @task = Task.new
    @users = family

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  def edit
    @users = User.where(parent_id: current_user.id)
    @users << current_user
    @task = Task.find(params[:id])
  end

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

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to user_path(@task.user) }
      format.json { head :no_content }
    end
  end
end
