class MealsController < ApplicationController
  # GET /meals
  # GET /meals.json
  def index
    @meals = Meal.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @meals }
    end
  end

  def show
    @meal = Meal.find(params[:id])
    @ingredients = @meal.ingredients
    @all_ingredients = Ingredient.all

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @meal }
    end
  end

  def new
    @meal = Meal.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @meal }
    end
  end

  def edit
    @meal = Meal.find(params[:id])
  end

  def create
    @meal = Meal.new(params[:meal])

    @meal.user_id = current_user.id

    respond_to do |format|
      if @meal.save
        format.html { redirect_to @meal, notice: 'Meal was successfully created.' }
        format.json { render json: @meal, status: :created, location: @meal }
      else
        format.html { render action: "new" }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @meal = Meal.find(params[:id])

    if @meal.user_id == nil
      @meal.user_id == current_user.id
    end

    respond_to do |format|
      if @meal.update_attributes(params[:meal])
        format.html { redirect_to @meal, notice: 'Meal was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @meal = Meal.find(params[:id])
    @meal.destroy

    respond_to do |format|
      format.html { redirect_to meals_url }
      format.json { head :no_content }
    end
  end
end
