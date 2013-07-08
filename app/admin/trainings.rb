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
      	link_to training.attendee.email, admin_attendee_path(training.attendee)
      end
      default_actions
    end
  
end
