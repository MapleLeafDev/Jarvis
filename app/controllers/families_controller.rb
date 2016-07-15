class FamiliesController < ApplicationController
  respond_to :html, :js
  before_filter :authorize, except: [:my_family]
  before_filter :is_parent, except: [:my_family, :show]

  def show
    @family = Family.find(params[:id])
    @members = @family.parents + @family.children
  end

  def my_family
    unless @family = Family.find_by_url(params[:url])
      redirect_to root_url
    end
  end

  def new
    @family = Family.new
  end

  def edit
    @family = Family.find(params[:id])
  end

  def create
    if @family = Family.find_by_url(params[:family][:url])
      current_user.update_attribute(:family_id, @family.id)
      redirect_to @family, notice: t('added_to_family')
    else
      @family = Family.new(family_params)
      @family.url = @family.name + "-" + Random.new.rand(1000000000..10000000000).to_s
      respond_to do |format|
        if @family.save
          current_user.update_attribute(:family_id, @family.id)
          format.html { redirect_to @family, notice: t('family_created') }
        else
          format.html { render action: "new" }
        end
      end
    end
  end

  def update
    @family = Family.find(params[:id])
    flash[:notice] = t('family_updated') if @family.update_attributes(family_params)
    respond_with @family
  end

  def destroy
    @family = Family.find(params[:id])
    @family.children.each{|user| user.destroy}
    @family.destroy
    redirect_to current_user
  end

  private

  def family_params
    params.require(:family).permit!
  end
end
