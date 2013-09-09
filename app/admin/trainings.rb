ActiveAdmin.register Training do
	index do |train|
      column :id
      column("Pembayaran") do |training|       	
      	training.payment_status ? training.payment_status : "-"
      end
      column("Pre-test") do |training|
      	training.pretest_status ? training.pretest_status : "-"	
      end
      column("Lokasi Training") do |training|
      	training.training_location ? training.training_location.name : "-"
      end
      column("Peserta") do |training|
       	link_to training.attendee.name, admin_attendee_path(training.attendee) if training.attendee
       end
      column("Jadwal Training") do |training|
            training.training_schedule ? training.training_schedule.training_date : "-"
      end            
      column("Status Buku") do |training|
            training.book_delivery_status ? training.book_delivery_status : "-"
      end            
      default_actions
    end
  
end
