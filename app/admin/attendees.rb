ActiveAdmin.register Attendee do	

  filter :name, :as => :string    
  filter :campus_name, :as => :string    
  filter :office_name, :as => :string    
  filter :email, :as => :string    
  filter :training_payment_status, :as => :select, :collection => Training::PAYMENT_STATUSES
  filter :training_pretest_status, :as => :select, :collection => Training::PRETEST_STATUSES
  filter :training_training_location_name, :as => :select, :collection => TrainingLocation.all.map{|location|[location.name, location.name]}, :label => "Training Location"
  filter :training_training_schedule_training_date, :as => :select, :collection => TrainingSchedule.all.map{|schedule|[schedule.training_date, schedule.training_date]}, :label => "Training Schedule"

  filter :training_book_delivery_status, :as => :select, :collection => Training::BOOK_STATUSES, :lable => "Book Status"


  collection_action :new_attendee_training_registration, :method => :post do
    @attendee = Attendee.create_attendee_with_completed_payment(params[:attendee])
    if @attendee.valid?
      redirect_to admin_attendees_path      
    else
      render active_admin_template('new.html.arb'), layout: false
    end
  end

  member_action :edit_attendee_training_registration, :method => :put do
    @attendee = Attendee.update_attendee_with_completed_payment(params[:id], params[:attendee])
    unless @attendee.errors.blank?
      render active_admin_template('edit.html.arb'), layout: false 
    else
      redirect_to admin_attendees_path      
    end
  end


	index do                            
    column :name                     
    column :created_at        
    column :phone
    column("Payment") {|attendee| attendee.training.payment_status}  
    column("Training Location") {|attendee| attendee.training_location ? attendee.training_location_name : "-" }           
    column("Training Schedule") {|attendee| attendee.training_schedule ? attendee.training_schedule.training_date : "-" }           
    column("Pre-test") {|attendee| attendee.training.pretest_status }  
    column("Campus") {|attendee| attendee.campus ?  attendee.campus.name : "-" }           
    column("Office") {|attendee| attendee.office_name.blank? ? "-" : attendee.office_name }           
    column("Email") {|attendee|attendee.email.blank? ?  "-" : attendee.email }    
    column("Book Status") {|attendee| attendee.training.book_delivery_status.blank? ? "-" : attendee.training.book_delivery_status }    


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
  end  

  form :partial => "form"          

  controller do
    def max_csv_records; @per_page; end
  end
end
