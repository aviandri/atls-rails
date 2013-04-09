class OrdersController < ApplicationController
	def new

		@order = Order.new
		@order.attendees << Attendee.new
	end

	def create
		@order = Order.new(params[:order])
		respond_to do |format|
			if @order.save		
				puts @order.attendees[0].name
				format.html{ redirect_to(:action => "complete", :order_id => @order.id, :notice => "order was created")}		
			else
				format.html {render :action => "new"}
			end
		end
	end

	def complete
		@order = Order.find(params[:order_id])
		@cost = 4500000
		@cost_id = @order.id % 100
	end
end
