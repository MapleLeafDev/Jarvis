class EventsController < ApplicationController

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

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  def new
    @event = Event.new
    @users = current_user.family.users

    if params[:start_time]
      @event.start_time = "#{params[:start_time]} 8:00AM"
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  def edit
    @event = Event.find(params[:id])
    @users = family
    @meals = Meal.where(user_id: (family.collect(&:id))).collect(&:name)
  end

  def create
    @event = Event.new(event_params)
    @event.start_time = params[:start_time]
    @event.event_type = params[:event_type]
    if @event.event_type == "meal"
      @event.name = params[:meal_name]
    end

    respond_to do |format|
      if @event.save
        format.html { redirect_to events_path, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        @users = family
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @event = Event.find(params[:id])
    @event.start_time = params[:start_time]
    @event.event_type = params[:event_type]
    if @event.event_type == "meal"
      @event.name = params[:meal_name]
    end

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to events_path, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
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