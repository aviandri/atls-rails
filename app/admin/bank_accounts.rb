ActiveAdmin.register BankAccount do

	controller do
    	def max_csv_records; @per_page; end
  	end
  
end
