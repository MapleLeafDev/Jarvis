class TasksController < ApplicationController
  respond_to :html, :js

  before_filter :authorize

  def index
    @family = current_user.family
    @members = @family.users
    @tasks = @family.tasks
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(task_params)
    @task.family_id = current_user.family_id
    if @task.save
      flash[:notice] = t('task_created', task: @task.title)
    end
    respond_with @task
  end

  def update
    @task = Task.find(params[:id])

    flash[:notice] = t('task_updated', task: @task.title) if @task.update_attributes(task_params)
    respond_with @task
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    redirect_to '/tasks'
  end

  private

  def task_params
    params.require(:task).permit!
  end
end
