class CommandLineController < ApplicationController
  def show
    
  end

  def run
    temp = `#{params[:command]}`
    @results = temp ? temp.split(/\r?\n/) : ["nil"]
  end
end
