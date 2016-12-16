class CompletionsController < ApplicationController
  before_filter :authorize

  def complete_task
    @task = Task.find_by_id(params[:task])
    user = params[:user] ? User.find(params[:user]) : current_user

    if @task && !@task.completed?
      Completion.create(user_id: user.id, task_id: @task.id, completed: @task.today)
    end
  end

  def who
    
  end

  def destroy
    @completion = Completion.find(params[:id])

    user = @completion.user
    task = @completion.task

    if @completion.destroy
      user.credits = user.credits.to_i - task.points.to_i
      user.save
    end
  end
end
