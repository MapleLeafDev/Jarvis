class FamiliesController < ApplicationController
  respond_to :html, :js
  before_filter :authorize, except: [:my_family]
  before_filter :is_parent, except: [:my_family, :show]

  layout :resolve_layout

  def show
    @family = Family.find(params[:id])

    @members = @family.parents + @family.children

    @access_url = "http://#{Rails.env.development? ? request.host_with_port : 'www.ml-family.com'}/my_family/" + @family.url

    respond_to do |format|
      format.html.phone { render template: "families/show_m" }
      format.html # show.html.erb
      format.json { render json: @family }
    end
  end

  def my_family
    @family = Family.find_by_url(params[:url])

    respond_to do |format|
      if @family
        @users = Array.new
        @family.users.each do |user|
          if user.child?
            @users << user
          end
        end
        format.html.phone { render template: "families/my_family_m" }
        format.html
      else
        format.html { redirect_to root_url }
      end
    end
  end

  def new
    @family = Family.new
  end

  def edit
    @family = Family.find(params[:id])
  end

  def create
    @family = Family.find_by_url(params[:family][:url])

    if @family
      current_user.update_attribute(:family_id, @family.id)
      respond_to do |format|
        format.html { redirect_to @family, notice: 'Added to existing family.' }
      end
    else
      @family = Family.new(family_params)
      random_id = Random.new()
      @family.url = @family.name + "-" + random_id.rand(1000000000..10000000000).to_s

      respond_to do |format|
        if @family.save
          current_user.update_attribute(:family_id, @family.id)
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

  def multi
    @family = Family.find(params[:id])
    @task = @family.tasks.new()
    @user = @family.users.new()
  end

  def destroy
    @family = Family.find(params[:id])

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

  private

  def family_params
    params.require(:family).permit!
  end
end
