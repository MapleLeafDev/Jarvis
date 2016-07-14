class EventsController < ApplicationController
  respond_to :html, :js

  def index
    @events = Array.new
    @family = current_user.family.users
    @family.each do |member|
      Event.where(user_id: member.id).each do |event|
        @events << event
      end
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
    @users = current_user.family.users
  end

  def edit
    @event = Event.find(params[:id])
    @users = current_user.family.users
    # @meals = Meal.where(user_id: (family.collect(&:id))).collect(&:name)
  end

  def create
    @event = Event.new(event_params)
    @event.name = params[:meal_name] if @event.event_type == "meal"

    if @event.save
      flash[:notice] = t('event_created', event: @event.name)
    end
    respond_with @event
  end

  def update
    @event = Meal.find(params[:id])
    flash[:notice] = t('event_updated', event: @event.name) if @event.update_attributes(event_params)
    respond_with @meal
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit!
  end
end
