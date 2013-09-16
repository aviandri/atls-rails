json.training_schedules @training_schedules do |row|
	json.location_name		row.training_location.name
	json.id					row.id
	json.training_date		row.training_date.strftime("%-d-%-m-%Y")
end