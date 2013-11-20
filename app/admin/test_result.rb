ActiveAdmin.register TestResult, as: "Hasil Pretest" do
	index do       
		column :id     
		column :attendee                
	    column :number_of_question                               
	    column :score	    
	    column :created_at
	    default_actions                   
  end 
end
