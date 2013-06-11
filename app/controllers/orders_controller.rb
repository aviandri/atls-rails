class OrdersController < ApplicationController
	

	def new
		@order = Order.new
		@order.attendees << Attendee.new
	end

	def create
		binding.pry
		@order = Order.new(params[:order])
		@order.status = "pending"
		@order.attendee = current_attendee
		respond_to do |format|
			if @order.save						
				format.html{redirect_to(:controller => "attendees", :action => "home")}		
			else
				format.html {render :action => "new"}
			end
		end
	end

	def index
		if params[:status]
			if params[:status] == 'pending' 
				@orders = current_attendee.orders.pending
			elsif params[:status] == 'completed'
				@orders = current_attendee.orders.completed
			elsif params[:status] == 'canceled'
				@orders = current_attendee.orders.cancelled
			else
				@orders = current_attendee.orders
			end
		else
			@orders = current_attendee.orders
		end
		respond_to do |format|
			format.json {render :json => {:order => @orders, 
				:count => @orders.count}}
		end
	end

	def complete
		@order = Order.find(params[:order_id])
		@cost = 4500000
		@cost_id = @order.id % 100
	end

end
