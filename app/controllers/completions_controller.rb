class CompletionsController < ApplicationController

  def complete_task
    @completion = Completion.new

    user = User.find_by_id(params[:user])
    task = Task.find_by_id(params[:task])

    @completion.user_id = user.id
    @completion.task_id = task.id
    @completion.completed = Date.today

    if Completion.find_by_user_id_and_task_id_and_completed(user.id, task.id, Date.today) == nil
      if @completion.save
        user.credits = user.credits.to_i + task.points.to_i
        user.save
      end
    end
  end

  def destroy
    @completion = Completion.find(params[:id])

    user = User.find_by_id(@completion.user_id)
    task = Task.find_by_id(@completion.task_id)

    if @completion.destroy
      user.credits = user.credits.to_i - task.points.to_i
      user.save
    end
  end
end
