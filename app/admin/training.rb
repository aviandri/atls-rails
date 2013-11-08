ActiveAdmin.register Training do

	form :partial => "form"       

	action_item :only => :show do     
    	link_to("Confirm Pembayaran", confirm_admin_training_path(:id => training.id), :method => :put)	      	
  	end   

	member_action :confirm, :method => :put do
	    training = Training.find params[:id]
	    training.confirm_payment
	    redirect_to admin_trainings_path
  	end

	index do                   
		column :id         
	    column :attendee                     
	    column("Tanggal Daftar"){|training| training.created_at}        
	    column :status
	    column("Lokasi"){|training| training.training_location ? training.training_location.name : ""}    
	    column("Jadwal") {|training| training.training_schedule ?  readable_date(training.training_schedule.training_date) : "-" }           
	    column("Biaya") {|training| training.price || "-" }           
	    column("Kode Pembayaran") {|training| training.payment_code || "-" }    
	    column("Terbayar") {|training| training.amount_paid || "-" }    

	    column("Confirm") do |training|
	      link_to("Confirm Pembayaran", confirm_admin_training_path(:id => training.id), :method => :put)	      	
    	end    

	    default_actions                   
  	end  


end
