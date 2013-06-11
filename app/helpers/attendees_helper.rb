module AttendeesHelper

	def has_error(name, obj)
		if obj.errors.any?
			if obj.errors[name.to_sym].any?
				return 'error'
			end
		end
	end

	def get_error_message(name, obj)
		if obj.errors.any?
			if obj.errors[name.to_sym].any?
				obj.errors.messages[name.to_sym].first			
			end
		end
	end

end
