class MealsController < ApplicationController
  respond_to :html, :js

  before_filter :authorize

  def index
    @family = current_user.family
    @meals = @family.meals

    @today = Date.today
    @this_week = (@today.at_beginning_of_week..@today.at_end_of_week).to_a
    @next_week = ((@today + 7.days).at_beginning_of_week..(@today + 7.days).at_end_of_week).to_a

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @meals }
    end
  end

  def new
    family = current_user.family
    @meal = family.meals.new()
  end

  def edit
    @meal = Meal.find(params[:id])
  end

  def create
    @meal = Meal.new(meal_params)

    if @meal.save
      flash[:notice] = t('controllers.meal_created', meal: @meal.name)
    end
    respond_with @meal
  end

  def update
    @meal = Meal.find(params[:id])

    flash[:notice] = t('controllers.meal_updated', meal: @meal.title) if @meal.update_attributes(meal_params)
    respond_with @meal
  end

  def destroy
    @meal = Meal.find(params[:id])
    @meal.destroy

    respond_to do |format|
      format.html { redirect_to meals_url }
      format.json { head :no_content }
    end
  end

  def assign_meal
    @meal = Meal.find_by_id(params[:id])

    if @meal
      @old_meal = Meal.find_by_menu_day(params[:menu_day])
      if @old_meal
        @old_meal.menu_day = nil
        @old_meal.save
      end
      @old_day = @meal.menu_day
      @meal.menu_day = params[:menu_day]
      if @meal.save && @meal.menu_day
        @meal.add_activity
      end
    end

    respond_to do |format|
      format.js
    end
  end

  private

  def meal_params
    params.require(:meal).permit!
  end
end
