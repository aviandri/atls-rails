ActiveAdmin.register Attendee, as: "Peserta" do

  filter :name, :as => :string    
  filter :campus_name, :as => :string    
  filter :office_name, :as => :string    
  filter :email, :as => :string
  filter :gender, :as => :select, :collection => [["male"],["female"]]    
  filter :trainings_training_location_name, :as => :select, :collection => TrainingLocation.all.map{|location|[location.name, location.name]}, :label => "Training Location"
  filter :trainings_training_schedule_training_date, :as => :select, :collection => TrainingSchedule.all.map{|schedule|[schedule.training_date, schedule.training_date]}, :label => "Training Schedule"


  xlsx do
      delete_columns :created_at, :updated_at, :amount_paid, :amount_unpaid, :payment_code, :test_score, :description, :group_number, :password, :password_confirmation, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :book_status, :nick_name, :religion, :campus_name, :campus_address, :campus_phone, :id
  end

  action_item :only => :show do     
    link_to 'Create Training', new_admin_training_path(:attendee_id => params[:id])
  end

  action_item :only => :show do
      link_to 'Change Password', :action => "change_password"
  end

  member_action :change_password do
      @attendee = Attendee.find(params[:id])
      render "admin/attendees/change_password"
  end


  member_action :update_password, :method => :put do
    attendee = Attendee.find(params[:id])
    attendee.update_attributes(params["attendee"])

    if attendee.save
      flash[:info] = "Password Changed"
      redirect_to admin_pesertum_path(:id => attendee.id)
    else
      flash[:errors] = attendee.errors.full_messages.to_sentence
      redirect_to change_password_admin_pesertum_path(:id => attendee.id)
    end

  end

  collection_action :new_attendee_training_registration, :method => :post do
    @attendee = Attendee.create(params[:attendee])
    if @attendee.valid?
      redirect_to admin_attendees_path      
    else
      render active_admin_template('new.html.arb'), layout: false
    end
  end

  member_action :edit_attendee_training_registration, :method => :put do
    # @attendee = Attendee.update_attendee_with_completed_payment(params[:id], params[:attendee])
    unless @attendee.errors.blank?
      render active_admin_template('edit.html.arb'), layout: false 
    else
      redirect_to admin_attendees_path      
    end
  end


	index do                            
    column :id         
    column :name
    column :created_at        
    column :phone    
    column("Campus") {|attendee| attendee.campus ?  attendee.campus.name : "-" }           
    column("Office") {|attendee| attendee.office_name.blank? ? "-" : attendee.office_name }           
    column("Email") {|attendee|attendee.email.blank? ?  "-" : attendee.email }    
    column("Status Pretest") {|attendee|attendee.is_complete_pretest? ? "Done" :  "-"}    
    column("Show Training"){|attendee| link_to("Show Trainings", admin_trainings_path("q[attendee_id_eq]" => "#{attendee.id}") )}

    default_actions                   
  end  

  show do |attendee|
    panel "attendee detail" do
        attributes_table do
        row :name
        row :date_of_birth
        row :place_of_birth
        row :gender
        row :religion
        row :address
        row :phone
        row :cell_number
        row :email
        row :password               
        row :password_confirmation        
      end    
    end
    
    panel "office detail" do
        attributes_table do
        row :office_name
        row :job_title
        row :office_address
        row :office_phone
      end    
    end
    panel "campus detail" do
        attributes_table do
          row :campus_name
          row :campus_address
          row :campus_phone         
      end    
    end
    panel "others" do
        attributes_table do
          row("Status Pretest"){|attendee| attendee.is_complete_pretest? ? "Done" :  "-"}
          row("Status Buku"){|attendee| attendee.book_status }
      end    
    end
    panel "trainings" do
      table_for attendee.trainings do 
        column :type
        column :status
        column do |training|
          link_to('Edit', edit_admin_training_path(training)) + "  " + link_to('View', admin_training_path(training))
        end
      end
    end
  end  

  form :partial => "admin/attendees/form"      

  member_action :approve, :method => :put do
      order = Order.find params[:id]
      order.complete_order
      redirect_to admin_orders_path
  end

  action_item :only => :index do
      link_to 'Upload CSV', :action => 'upload_csv'
    end

    collection_action :upload_csv do
      render "admin/attendees/upload_xls"
    end

    collection_action :import_csv, :method => :post do
        tmp = params[:dump][:file].tempfile
        file = File.join("public", params[:dump][:file].original_filename)
        FileUtils.cp tmp.path, file
        attendee_attributes_arrray = []

        exl = Roo::Excel.new(file)    
        ((exl.first_row + 1)..exl.last_row).each do |i|
            name = exl.cell(i, "A")
            dob = exl.cell(i, "B")
            gender = exl.cell(i, "C")   
            address  = exl.cell(i, "D")   
            phone = exl.cell(i, "E")   
            email = exl.cell(i, "F")   
            office_name = exl.cell(i, "G")    
            office_address = exl.cell(i, "H")     
            office_phone = exl.cell(i, "I")     
            job_title = exl.cell(i, "J")    
            pob = exl.cell(i, "K")     
            cell_number = exl.cell(i, "L")    
            graduation_year = exl.cell(i, "M")    
            campus_name = exl.cell(i, "N")               
            
            campus = Campus.find_by_name(campus_name)

            attendee_attributes = {name: name, date_of_birth: dob, gender: gender, address: address, phone: phone, 
              email: email, office_name: office_name, office_address: office_address, office_phone: office_phone, job_title: job_title, place_of_birth: pob, cell_number: cell_number,
              graduation_year: graduation_year, campus_id: campus ? campus.id : nil}

            attendee_attributes_arrray << attendee_attributes            
        end                

        begin
            Attendee.create_multiple_attendees(attendee_attributes_arrray)            
            redirect_to admin_peserta_path
        rescue ActiveRecord::RecordInvalid => invalid
            flash[:errors] = invalid.record.errors.full_messages
        end
    end


  controller do
    def max_csv_records; @per_page; end
  end
end
