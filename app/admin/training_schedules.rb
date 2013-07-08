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
    default_actions                   
  end 


end
