ActiveAdmin.register News, as: "Berita" do

	form(:html => {:multipart => true}) do |f|
		f.inputs do
			f.input :title         
			f.input :body, :as => :html_editor
		end
			f.actions
	end

end
