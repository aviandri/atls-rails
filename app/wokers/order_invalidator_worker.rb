class OrderInvalidatorWorker
	include Sidekiq::Worker

	def perform(order_id)
		order = Order.find order_id
		order.cancel_order
	end
end