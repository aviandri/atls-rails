class OrdersController < ApplicationController
	respond_to :json, :only => [:payment_code]
	
	PAYMENT_MODAL_INDEX = 500
	TRAINING_PACKAGE_PRICE = 4500000


	def new
		@order = Order.new
		@order.attendees << Attendee.new

		@term_payment = PaymentTerm::TERM
		if current_attendee.training.payment_status == PaymentTerm::TERM_FIRST_INSTALLMENT
			@term_payment.delete(TERM_FIRST_INSTALLMENT)
		end	
	end


	def payment_code
		payment_code = PaymentCodeCounter.create
		@payment_code = payment_code.id % 500
		render :json => {:payment_code => @payment_code}
	end

	def create
		@order = Order.new(params[:order])
		@order.status = "pending"
		@order.attendee = current_attendee
		respond_to do |format|
			if @order.save	
				@order.payment_amount = TRAINING_PACKAGE_PRICE + (@order.id % PAYMENT_MODAL_INDEX)					
				@order.save
				format.html{redirect_to(:controller => "homes", :action => "index")}		
			else
				format.html {render :controller=> "home", :action => "index"}
			end
		end
	end


	def destroy
		@order = Order.find(params[:id])

		if @order.destroy
			redirect_to(:controller => "homes", :action => "index")
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
