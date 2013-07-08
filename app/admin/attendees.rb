ActiveAdmin.register Attendee do	
	index do                            
    column :name                     
    column :created_at        
    column :phone           
    column("Email") {|attendee|attendee.email ? attendee.email : "-"}    
    default_actions                   
  end                   
end
