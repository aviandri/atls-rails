ActiveAdmin.register Attendee do	
	index do                            
    column :name                     
    column :created_at        
    column :phone
    column("Kampus") {|attendee| attendee.campus_name ? attendee.campus_name : "-"}           
    column("Email") {|attendee|attendee.email ? attendee.email : "-"}    
    column("Action") do |attendee|
	     link_to("Show Training", admin_trainings_path("q[attendee_id_eq]" => attendee.id))	      	
    end    

    default_actions                   
  end  

  form do |f|
    f.inputs "Attendee Details" do
      f.input :name
      f.input :date_of_birth, :as => :date_picker
      f.input :place_of_birth
      f.input :gender, :as => :select, :collection => ["Male", "Female"]
      f.input :religion
      f.input :address
      f.input :phone
      f.input :email
      f.input :password               
      f.input :password_confirmation        
      # name, date_of_birth, place_of_birth, gender, religion, address, phone, email, office_name, job_title, office_address, office_phone, campus_name, campus_address, campus_phone        
    end
    f.inputs "Office Details" do
      f.input :office_name
      f.input :job_title
      f.input :office_address
      f.input :office_phone
    end
    f.inputs "Campus Details" do
      f.input :campus_name
      f.input :campus_address
      f.input :campus_phone
    end
    f.actions
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
end
