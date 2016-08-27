class RegistrationsController < ApplicationController
  protect_from_forgery except: :hook
  skip_before_filter  :verify_authenticity_token, only: [:create]

  def new
    @family = current_user.family
    @registration = Registration.new(email: current_user.email, family_id: @family.id, course_id: 100)
  end

  def create
    @registration = Registration.new(registration_params)
    if @registration.valid?
      @registration.process_payment
      @registration.save
      redirect_to "/family", notice: t('registration_successful')
    else
      render :new
    end
  end

  def hook
    event = Stripe::Event.retrieve(params["id"])
    puts "EVENT #{event.inspect}"
    case event.type
    when "invoice.payment_succeeded" # renew subscription
      Registration.find_by_customer_id(event.data.object.customer).renew
    when "subscription.deleted"      # cancel subscription
      Registration.find_by_customer_id(event.data.object.customer).expire
    end
    render status: :ok, json: "success"
  end

  private

  def registration_params
    params.require(:registration).permit(:course_id, :card_token, :family_id, :email)
  end
end
