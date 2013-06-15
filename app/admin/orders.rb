ActiveAdmin.register Order do

	index do
		column "id" do |order|
			link_to(order.id, :action => "show", "id" => order.id)
		end
		column :status
		column :payment_type
		column :created_at
		column :updated_at
		column "peserta" do |order|
			link_to(order.attendee.name, :controller => "attendees", :action => "show", :id => order.attendee.id)
		end

	end

	form do |f|
		f.inputs "Orders" do			
			f.input :status, as: :select, :collection => ["pending", "completed", "canceled"]	
		end
		

	end

end
