module HomesHelper

	def has_error(name, obj)
		if obj.errors.any?
			if obj.errors[name.to_sym].any?
				return 'error'
			end
		end
	end

	def status_bar_style		
		if flash[:info]
			"success"
		else
			"error"
		end
	end

	def get_error_message(name, obj)
		if obj.errors.any?
			if obj.errors[name.to_sym].any?
				obj.errors.messages[name.to_sym].first			
			end
		end
	end
	
	def order_label_string(status)
		if status == Order::ORDER_STATUSES[1]
			return 'label-warning'
		elsif status == Order::ORDER_STATUSES[2]
			return 'label-important'
		elsif status == Order::ORDER_STATUSES[0]
			return 'label-success'
		end
	end

	def test_result_element(is_pass_test)
		if is_pass_test
			return content_tag(:p,  "Lulus!", :class=> "text-success big-font")			
		else
			return content_tag(:p, "Tidak Lulus!", :class=> "text-error big-font")			
		end
	end

	def test_score_style(is_pass_test)
		if is_pass_test
			return "text-success"
		else
			return "text-error"
		end
	end

	def payment_status(training)
		if training.payment_done?
			return content_tag(:span, "Done", :class=> "label-title")
		else
			return content_tag(:span, "Not Done", :class=> "label-title")
		end
	end

	def pretest_status(training)
		if training.pretest_done?
			return content_tag(:span, "Done", :class=> "label-title")
		else
			return content_tag(:span, "Not Done", :class=> "label-title")
		end
	end

	def time_location_status(training)
		if training.payment_status
			return content_tag(:span, "Done", :class=> "label-title")
		else
			return content_tag(:span, "Not Done", :class=> "label-title")
		end
	end

	def time_location_button(training)
		if training.payment_status && training.pretest_status
			return ""
		else
			return "disabled='true'"
		end
	end

	def cancel_order_button(order)
		"<td><button type='submit' class='m-btn red'>Batal</button></td>".html_safe	unless order.status == Order::STATUS_COMPLETED
	end

	def payment_button(training)


	end

	def training_types_for_select
		Training::TRAINING_TYPES.map{|t|[t]}
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
