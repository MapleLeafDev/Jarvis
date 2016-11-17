class CompletionsController < ApplicationController
  before_filter :authorize

  def complete_task
    @task = Task.find_by_id(params[:task])

    if @task && !@task.completed?
      d = Time.now + Time.now.in_time_zone(current_user.timezone).utc_offset
      Completion.create(user_id: current_user.id, task_id: @task.id, completed: "#{d.year}-#{d.month}-#{d.day}")
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
