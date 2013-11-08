ActiveAdmin.register News do

	form(:html => {:multipart => true}) do |f|
		f.inputs do
			f.input :title         
			f.input :body, :as => :html_editor
		end
			f.actions
	end

end
