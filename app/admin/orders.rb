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
			map  = order.attendees.map {|i| {"id" => i.id, "name" => i.name} unless i.id.nil? && i.name.nil?}
			b = map.map{|a|
				link_to(a["name"], :controller => "attendees", :action => "show", :id => a["id"])
			}	
			b[0]
		end

	end

end
