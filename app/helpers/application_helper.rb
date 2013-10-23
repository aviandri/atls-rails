module ApplicationHelper

	def readable_date(date)
		date.strftime("%B %d, %Y")
	end

	def number_to_currency_rupiah(number)
		number_to_currency(number, unit: "", separator: ".", precision: 0)
	end

 
end
