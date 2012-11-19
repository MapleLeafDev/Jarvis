class CompletionsController < ApplicationController

  def new
    @completion = Completion.new

    user = User.find_by_id(params[:user_id])
    task = Task.find_by_id(params[:task])

    @completion.user_id = user.id
    @completion.task_id = task.id
    @completion.completed = Date.today
    if @completion.save
      user.credits = user.credits.to_i + task.points.to_i
      user.save
    end

    respond_to do |format|
      format.html { redirect_to :back}
    end
  end

  def destroy
    @completion = Completion.find(params[:id])
    @completion.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end
end
