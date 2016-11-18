class TasksController < ApplicationController
  respond_to :html, :js

  before_filter :authorize

  def index
    @family = current_user.family
    @members = @family.users.order(:dob)
    @tasks = Task.sort_by_member(@family.id)
  end

  def new
    @task = Task.new
    @assigned = []
  end

  def edit
    @task = Task.find(params[:id])
    @assigned = @task.assigned ? @task.assigned.split(",") : []
  end

  def create
    @task = Task.new(task_params)
    @task.family_id = current_user.family_id
    @task.assigned = params[:assigned].select{|k,v| v == "on"}.keys.join(",")
    if @task.save
      flash[:notice] = t('task_created', task: @task.title)
    end
    respond_with @task
  end

  def update
    @task = Task.find(params[:id])
    @task.assigned = params[:assigned].select{|k,v| v == "on"}.keys.join(",")
    flash[:notice] = t('task_updated', task: @task.title) if @task.update_attributes(task_params)
    respond_with @task
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
  end

  private

  def task_params
    params.require(:task).permit!
  end
end
