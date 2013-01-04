class EventsController < ApplicationController

  def index
    @events = Array.new
    family.each do |member|
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
    @users = family

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  def edit
    @event = Event.find(params[:id])
    @users = family
  end

  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to events_path, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @event = Event.find(params[:id])

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

  end
end