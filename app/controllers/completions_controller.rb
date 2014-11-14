class CompletionsController < ApplicationController
  before_filter :authorize

  def complete_task
    @task = Task.find_by_id(params[:task])
    @user = User.find_by_id(params[:user])

    if @task && @user
      unless @task.completed?
        if Completion.create(user_id: @user.id, task_id: @task.id, completed: Time.zone.today)
          @user.update_attribute(:credits, @user.credits.to_i + @task.points.to_i)
        end
      end
    end
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
