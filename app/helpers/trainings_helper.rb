module TrainingsHelper

	def training_types_for_select
		Training::TRAINING_TYPES.map{|t|[t, "#{t}Training"]}
	end

	def training_location_for_select
		TrainingLocation.all.map{|t|["#{t.name}/Rp.#{t.price}", t.id]}
	end

	def payment_status_string(status)
		if status == Training::PAYMENT_STATUSES[3]
			return 'status-label-important'			
		elsif status == Training::PAYMENT_STATUSES[2] || status == Training::PAYMENT_STATUSES[1]
			return 'status-label-warning'
		elsif status == Training::PAYMENT_STATUSES[0]
			return 'status-label-success'
		end

	end
end
