json.training_schedules @training_schedules do |row|
	json.id					row.id
	json.training_date		row.training_date.strftime("%-d-%-m-%Y")
end