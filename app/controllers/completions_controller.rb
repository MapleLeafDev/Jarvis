class CompletionsController < ApplicationController
  before_filter :authorize

  def complete_task
    @completion = Completion.new(user_id: params[:user], task_id: params[:task], completed: Time.zone.today)

    unless Completion.find_by_user_id_and_task_id_and_completed(params[:user], params[:task], Time.zone.today)
      if @completion.save
        task = Task.find_by_id(params[:task])
        @user = current_user
        @user.credits = @user.credits.to_i + task.points.to_i
        @user.save
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
