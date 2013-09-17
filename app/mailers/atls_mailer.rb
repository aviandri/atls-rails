class AtlsMailer < ActionMailer::Base
  default from: "aviandri@gmail.com"

  def order_confirmation(order)
  	@order = order
  	mail(:to => order.attendee.email , :subject => "Thank you for your order", :from => "aviandri@gmail.com", :content_type => "text/html")
  end
	
end