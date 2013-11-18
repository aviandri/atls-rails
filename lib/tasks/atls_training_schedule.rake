namespace :atls_training_schedule do
  desc "TODO"
  task :importer => :environment do
  	exl = Roo::Excelx.new("/Users/aviandrihidayat/Documents/projects/atls-rails/atls-sample.xlsx")  
  	((exl.first_row+2)..exl.last_row).each do |i|
	  	training_location_name =   exl.cell(i, "B") 
	  	location = TrainingLocation.find_by_name(training_location_name)

	  	unless location
	  		TrainingLocation.create(name: training_location_name, price: 5000000)
	  	end
	end



  end

end
