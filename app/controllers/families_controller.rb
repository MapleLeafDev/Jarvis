class FamiliesController < ApplicationController

  def index
    @families = Family.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @families }
    end
  end

  def show
    @family = Family.find(params[:id])

    @access_url = "http://chore-chart.heroku.app.com/family/" + @family.url

    @users = Array.new
    FamilyMember.where(family_id: @family.id).each do |member|
      @users << User.find_by_id(member.user_id)
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @family }
    end
  end

  def new
    @family = Family.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @family }
    end
  end

  def edit
    @family = Family.find(params[:id])
  end

  def create
    @family = Family.new(params[:family])

    random_id = Random.new()
    @family.url = random_id.rand(1000000000..10000000000).to_s

    respond_to do |format|
      if @family.save
        FamilyMember.create(user_id: current_user.id, family_id: @family.id, admin: true)
        format.html { redirect_to @family, notice: 'Family was successfully created.' }
        format.json { render json: @family, status: :created, location: @family }
      else
        format.html { render action: "new" }
        format.json { render json: @family.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @family = Family.find(params[:id])

    respond_to do |format|
      if @family.update_attributes(params[:family])
        format.html { redirect_to @family, notice: 'Family was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @family.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @family = Family.find(params[:id])
    @family.destroy

    respond_to do |format|
      format.html { redirect_to current_user }
      format.json { head :no_content }
    end
  end
end
