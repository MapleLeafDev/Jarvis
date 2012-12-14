class FamiliesController < ApplicationController

  def show
    @family = Family.find(params[:id])

    @access_url = "http://chore-chart.herokuapp.com/my_family/" + @family.url

    @users = Array.new
    FamilyMember.where(family_id: @family.id).each do |member|
      @users << User.find_by_id(member.user_id)
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @family }
    end
  end

  def my_family
    @family = Family.find_by_url(params[:url])

    respond_to do |format|
      if @family
        @users = Array.new
        FamilyMember.where(family_id: @family.id).each do |member|
          user = User.find_by_id(member.user_id)
          if user.user_type < 10
            @users << user
          end
        end
        format.html
      else
        format.html { redirect_to root_url }
      end
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
    @family = Family.find_by_url(params[:family][:url])

    if @family
      FamilyMember.create(family_id: @family.id, user_id: current_user.id)
      respond_to do |format|
        format.html { redirect_to @family, notice: 'Added to existing family.' }
      end
    else
      @family = Family.new(params[:family])
      random_id = Random.new()
      @family.url = @family.name + "-" + random_id.rand(1000000000..10000000000).to_s

      respond_to do |format|
        if @family.save
          FamilyMember.create(user_id: current_user.id, family_id: @family.id)
          format.html { redirect_to @family, notice: 'Family was successfully created.' }
        else
          format.html { redirect_to @family, notice: 'Added to existing family.' }
        end
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

    members = FamilyMember.where(family_id: @family.id)

    members.each do |member|
      user = User.find_by_id(member.user_id)
      if user.user_type == 0
        user.destroy
      end
    end

    @family.destroy

    respond_to do |format|
      format.html { redirect_to current_user }
      format.json { head :no_content }
    end
  end
end
