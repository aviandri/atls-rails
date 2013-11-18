ActiveAdmin.register TrainingSchedule, as: "Jadwal Training" do
	
	form do |f|                         
	    f.inputs "Admin Details" do       
	      f.input :training_location, :as => :select, :collection => TrainingLocation.all        
	      f.input :training_date, :as => :date_picker
        f.input :quota
	    end                               
    f.buttons                         
  end           

  index do       
	column :id     
	column :training_location                
    column :training_date                               
    column :quota
    column("Registed Attendee"){|training_schedule| 
      link_to "#{Attendee.eligable_attendee_by_training_schedule(training_schedule).count}", admin_peserta_path("q[trainings_training_schedule_training_date_eq]" => training_schedule.training_date, "q[trainings_training_location_name_eq]" => training_schedule.training_location.name) 
    }

    default_actions                   
  end 


  controller do
    def max_csv_records; @per_page; end
  end

end
