class Registration < ActiveRecord::Base
  belongs_to :family

  def process_payment
    customer = Stripe::Customer.create(email: self.email, card: self.card_token, plan: 100)
    Stripe::Charge.create(customer: customer.id, amount: 8*100, description: 'Basic Plan', currency: 'usd')
    self.customer_id = customer.id
  end

  def renew
    update_attribute(:end_date, Date.today + 1.month)
  end

  def expire
    update_attribute(:end_date, Date.today)
  end
end
