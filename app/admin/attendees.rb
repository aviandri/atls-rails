ActiveAdmin.register Attendee do	
  action_item :only => :index do     
    link_to 'new complete', new_attendee_training_registration_admin_attendees_path, :method => :post      
  end

  collection_action :new_attendee_training_registration, :method => :post do
    @attendee = Attendee.create_attendee_with_completed_payment(params[:attendee])
    unless @attendee.errors.blank?
      render active_admin_template('new.html.arb'), :layout => false 
    else
      redirect_to admin_attendees_path      
    end
  end

  member_action :update_attendee_training_registration, :method => :put do
    @attendee = Attendee.update_attendee_with_completed_payment(params[:id], params[:attendee])
    unless @attendee.errors.blank?
      render active_admin_template('edit.html.arb'), :layout => false 
    else
      redirect_to admin_attendees_path      
    end
  end


	index do                            
    column :name                     
    column :created_at        
    column :phone
    column("Payment") {|attendee| attendee.training.payment_status.blank? ?  "-" : attendee.training.payment_status}  
    column("Training Location") {|attendee| attendee.training.training_location.blank? ? "-" : attendee.training.training_location.name }           
    column("Pre-test") {|attendee| attendee.training.pretest_status.blank? ?  "-" : attendee.training.pretest_status }  
    column("Campus") {|attendee| attendee.campus_name.blank? ?  "-" : attendee.campus_name}           
    column("Office") {|attendee| attendee.office_name.blank? ? "-" : attendee.office_name }           
    column("Email") {|attendee|attendee.email.blank? ?  "-" : attendee.email }    
    column("Book Status") {|attendee| attendee.training.book_delivery_status.blank? ? "-" : attendee.training.book_delivery_status }    
    column("Action") do |attendee|
	     link_to("Show Training", admin_trainings_path("q[attendee_id_eq]" => attendee.id))	      	
    end    

    default_actions                   
  end  

  # form do |f|
  #   f.inputs "Attendee Details" do
  #     f.input :name
  #     f.input :date_of_birth, :as => :date_picker
  #     f.input :place_of_birth
  #     f.input :gender, :as => :select, :collection => ["Male", "Female"]
  #     f.input :religion
  #     f.input :address
  #     f.input :phone
  #     f.input :email
  #     f.input :password               
  #     f.input :password_confirmation        
  #     # name, date_of_birth, place_of_birth, gender, religion, address, phone, email, office_name, job_title, office_address, office_phone, campus_name, campus_address, campus_phone        
  #   end
  #   f.inputs "Office Details" do
  #     f.input :office_name
  #     f.input :job_title
  #     f.input :office_address
  #     f.input :office_phone
  #   end
  #   f.inputs "Campus Details" do
  #     f.input :campus_name
  #     f.input :campus_address
  #     f.input :campus_phone
  #   end

  #   f.actions
  # end      

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
  end  

  form :partial => "form"          
end
