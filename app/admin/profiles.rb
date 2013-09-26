ActiveAdmin.register Profile do
	
form(:html => {:multipart => true}) do |f|
	f.inputs do
		f.input :name         
		f.input :bio, :as => :text
		f.input :avatar, :as => :file
	end
	f.actions
end

show do |profile|
  	attributes_table do
  		row :bio
  		row :name      	
		row :avatar do
          image_tag(profile.avatar.url)
        end

  	end
end

controller do
    def max_csv_records; @per_page; end
end


end
