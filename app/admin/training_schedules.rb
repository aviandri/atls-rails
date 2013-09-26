ActiveAdmin.register TrainingSchedule do
	
	form do |f|                         
	    f.inputs "Admin Details" do       
	      f.input :training_location, :as => :select, :collection => TrainingLocation.all
	      f.input :training_date, :as => :date_picker
	    end                               
    f.buttons                         
  end           

  index do       
	column :id     
	column :training_location                
    column :training_date                               
    column :quota
    column("Registed Attendee"){|training_schedule| Attendee.eligable_attendee_by_training_schedule(training_schedule).count}

    default_actions                   
  end 


  controller do
    def max_csv_records; @per_page; end
  end

end
