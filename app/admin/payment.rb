ActiveAdmin.register Payment do
	action_item :only => :show do     
    	link_to("Confirm Pembayaran", confirm_admin_training_path(:id => training.id), :method => :put)	      	
  	end   

	member_action :confirm, :method => :put do
	    payment = Payment.find params[:id]
	    payment.confirm_payment
	    redirect_to admin_training_path(:id => params[:training_id])
  	end	
end
