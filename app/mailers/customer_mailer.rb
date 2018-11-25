class CustomerMailer < ApplicationMailer

  def welcome_email(customer_id)
    @customer = Customer.find customer_id
    #attachments["sample.jpg"] = File.read("#{Rails.root}/public/hc05.jpg")
    mail to: @customer.email, subject: 'Welcome to my Food Ordering System'
  end
end
