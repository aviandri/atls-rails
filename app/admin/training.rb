ActiveAdmin.register Training do
	form :partial => "form"       


  xlsx do
      delete_columns :created_at, :updated_at, :amount_paid, :amount_unpaid, :payment_code, :test_score, :description, :group_number
      column("Peserta") { |resource| resource.attendee ? resource.attendee.name : "" }
  end
  

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

      panel "Test Detail" do
        attributes_table do
          row("Score"){|training| training.score }
          panel "Post Test" do
            table_for training.post_test_results do
              column("tanggal test"){|result| result.created_at}
              column("score"){|result| number_with_precision((result.score * 100 / result.number_of_question), precision: 2)}

            end
          end
        end
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
      column("Nilai Test") {|training| training.score || "-" }   


	    column("Confirm") do |training|
	      link_to("Confirm Pembayaran", confirm_admin_training_path(:id => training.id), :method => :put)	      	
    	end    

	    default_actions                   
  	end  

    action_item :only => :index do
      link_to 'Upload CSV', :action => 'upload_csv'
    end

    collection_action :upload_csv do
      render "admin/trainings/upload_xls"
    end

    collection_action :import_csv, :method => :post do
        tmp = params[:dump][:file].tempfile
        file = File.join("public", params[:dump][:file].original_filename)
        FileUtils.cp tmp.path, file

        exl = Roo::Excelx.new(file)    
        ((exl.first_row + 1)..exl.last_row).each do |i|
            id = exl.cell(i, "A") 
            score = exl.cell(i, "C").to_f 
          
            t = Training.find(id)
            t.score = score
            t.save
        end
        redirect_to admin_trainings_path
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

      def max_csv_records; @per_page; end

  	end


end
