class HomeController < ApplicationController

  layout "layouts/login"

  def index
    if current_user
      redirect_to current_user
    end
  end
end