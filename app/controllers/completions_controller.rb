class CompletionsController < ApplicationController
  before_filter :authorize

  def complete_task
    @completion = Completion.new

    user = User.find_by_id(params[:user])
    task = Task.find_by_id(params[:task])

    @completion.user_id = user.id
    @completion.task_id = task.id
    @completion.completed = Time.zone.today

    if Completion.find_by_user_id_and_task_id_and_completed(user.id, task.id, Time.zone.today) == nil
      if @completion.save
        user.credits = user.credits.to_i + task.points.to_i
        user.save

        @todays = params[:task_ids]
        @today_complete = Completion.where(completed: Time.zone.today.to_s, user_id: user.id, task_id: @todays).count
        @percent_done = @today_complete.to_f/@todays.count.to_f*100
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
