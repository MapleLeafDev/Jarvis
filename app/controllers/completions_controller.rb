class CompletionsController < ApplicationController

  def new
    @completion = Completion.new

    @completion.user_id = params[:user_id]
    @completion.task_id = params[:task]
    @completion.completed = Date.today
    @completion.save

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
