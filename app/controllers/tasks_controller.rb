class TasksController < ApplicationController
  respond_to :html, :js

  before_filter :authorize

  def index
    @family = current_user.family
    @members = @family.users
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(task_params)

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

    respond_to do |format|
      format.html { redirect_to user_path(@task.user) }
      format.json { head :no_content }
    end
  end

  private

  def task_params
    params.require(:task).permit!
  end
end
