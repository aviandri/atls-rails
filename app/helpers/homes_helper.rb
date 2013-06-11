module HomesHelper

	def order_label_string(status)
		if status == 'pending'
			return 'label-warning'
		elsif status == 'canceled'
			return 'label-important'
		elsif status == 'completed'
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
end
