ActiveAdmin.register Training do

	form :partial => "form"       
	

	member_action :confirm, :method => :put do
	    training = Training.find params[:id]
	    training.confirm_payment
	    redirect_to admin_trainings_path
  	end

  	show do |training|
  		attributes_table do
  			row("Peserta"){|training| link_to "#{training.attendee.name}", admin_pesertum_path(id: training.attendee.id)}
  			row("Status Training") {|training| training.status}
  			row("Status Pembayaran") {|training| training.payment_status}
  			row("Tipe Training"){|training| training.type}
  			row("Lokasi Training"){|training| training.training_location ? training.training_location.name : "-"}
  			row("Jadwal Training"){|training| training.training_schedule ? training.training_schedule.training_date : "-"}
        row("Group"){|training| training.group_number ? training.group_number : "-"}
  			row("Keterangan"){|training| training.description ? training.description.gsub(/\n/, '<br/>').html_safe : training.description}
  		end

  		panel "Pembayaran" do
  			table_for training.payments do
  				column("Jumlah Pembayaran"){|training|training.amount}
  				column("Status"){|t| t.status}
  				column("Tanggal Pembayaran"){|t| t.payment_date}
  				column("Action"){|t|
  					links = []
  					if t.status != Payment::PAYMENT_STATUS[1]  						
  						links << link_to("Konfirmasi", confirm_admin_payment_path(:id => t.id, :training_id => training.id), :method => :put) 
  					else
  						"-"
  					end
  					links << link_to("Delete", admin_payment_path(:id => t.id), :method => :delete)
  					safe_join links, "," 
  				}
  			end
  		end


  	end


	index do                   
		column :id         
	    column :attendee                     
      column("Tipe Training"){|training| training.type}
	    column("Tanggal Daftar"){|training| training.created_at.strftime("%B %d, %Y")}        
	    column ("Status"){|training| training.status}
	    column ("Status Pembayaran"){|training| training.payment_status}
	    column("Lokasi"){|training| training.training_location ? training.training_location.name : ""}    
	    column("Jadwal") {|training| training.training_schedule ?  readable_date(training.training_schedule.training_date) : "-" } 
      column("Group"){|training| training.group_number ? training.group_number : "-"}          
	    column("Biaya") {|training| training.price || "-" }           
	    column("Kode Pembayaran") {|training| training.payment_code || "-" }    
	    column("Terbayar") {|training| training.amount_paid || "-" }    

	    column("Confirm") do |training|
	      link_to("Confirm Pembayaran", confirm_admin_training_path(:id => training.id), :method => :put)	      	
    	end    

	    default_actions                   
  	end  

  	controller do
	    def new
		      @training = Training.new
		      @training.payments.build	
	    end

	    def edit
	    	@training = Training.find(params[:id])
	    	@training.payments.build
	    end

	    def update
	    	super
	    end

  	end


end
