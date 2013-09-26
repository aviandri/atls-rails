ActiveAdmin.register Blog do

form(:html => {:multipart => true}) do |f|
	f.inputs do
		f.input :title         
		f.input :body, :as => :html_editor
	end
	f.actions
end

index do       
	column :id                     
    column :title                     
    column :writer
    column :created_at
    column :updated_at             
    default_actions                   
 end  

 controller do
    def max_csv_records; @per_page; end
  end

end
