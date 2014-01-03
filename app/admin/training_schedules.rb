ActiveAdmin.register TrainingSchedule, as: "Jadwal Training" do
	
  action_item :only => :show do       
    link_to 'New Jadwal Training', new_admin_jadwal_training_path
  end

	form :partial => "admin/training_schedules/form"      
  index do       
	column :id     
	column :training_location                
    column :training_date                               
    column :quota
    column("Registed Attendee"){|training_schedule| 
      link_to "#{Attendee.eligable_attendee_by_training_schedule(training_schedule).count}", admin_peserta_path("q[trainings_training_schedule_training_date_eq]" => training_schedule.training_date, "q[trainings_training_location_name_eq]" => training_schedule.training_location.name) 
    }
    column("Show Trainings"){|training_schedule| link_to("Show Trainings", admin_trainings_path("q[training_schedule_id_eq]" => "#{training_schedule.id}") )}

    default_actions                   
  end 


  controller do
    def max_csv_records; @per_page; end
  end

end
