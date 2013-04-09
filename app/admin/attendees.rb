ActiveAdmin.register Attendee do	
	index do                            
    column :name                     
    column :created_at        
    column :phone           
    column :email             
    default_actions                   
  end                   
end
