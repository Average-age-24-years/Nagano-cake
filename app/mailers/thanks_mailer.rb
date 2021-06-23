class ThanksMailer < ApplicationMailer
  def send_when_create_order(order, customer)
    @order = order
    @customer = customer
    mail to: @customer.email, subject: '【NAGANO CAKE】 お買い上げいただきありがとうございます'
  end 
end
