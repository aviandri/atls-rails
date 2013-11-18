namespace :atls_training_schedule do
  desc "TODO"
  task :importer => :environment do
  	exl = Roo::Excelx.new("/Users/aviandrihidayat/Documents/projects/atls-rails/jadwal.xlsx")  
  	((exl.first_row+104)..exl.last_row).each do |i|
  		location_string = exl.cell(i, "A")
	  	location = TrainingLocation.find_by_name(location_string)

	  	unless location
	  		t = TrainingLocation.create(name: location_string, price: 5000000)
	  	end
	end



  end

end
