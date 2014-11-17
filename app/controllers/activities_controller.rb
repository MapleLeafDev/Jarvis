class ActivitiesController < ApplicationController

  def index
    @activities = current_user.family.activities.reverse
  end
end
