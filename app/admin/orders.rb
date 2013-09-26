ActiveAdmin.register Order do

	index do
		column "id" do |order|
			link_to(order.id, :action => "show", "id" => order.id)
		end
		column :status
		column :payment_type
		column :created_at
		column :updated_at
		column :payment_amount
		column :payment_code
		column "peserta" do |order|
			link_to(order.attendee.name, :controller => "attendees", :action => "show", :id => order.attendee.id) if order.attendee
		end				
		 column("Action") do |order|
	      	link_to("Approve", approve_admin_order_path(order.id), :method => :put)	      	
      	end    
      	default_actions
	end		

	member_action :approve, :method => :put do
	    Order.approve_order(params[:id])
	    redirect_to admin_orders_path
  	end

	  controller do
	    def max_csv_records; @per_page; end
	  end
end
