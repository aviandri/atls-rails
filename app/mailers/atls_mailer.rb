class AtlsMailer < ActionMailer::Base
  default from: "aviandri@gmail.com"

  def order_confirmation(order)
  	@order = order
  	mail(:to => order.attendee.email , :subject => "Thank you for your order", :from => "aviandri@gmail.com", :content_type => "text/html")
  end

  def send_forget_password(attendee_id, token)
  	@resource = Attendee.find attendee_id
  	@token = token
  	mail(:to => @resource.email , :subject => "Notifikasi Post Test", :from => "support@atls-indo.com", :content_type => "text/html")
  end
	
end