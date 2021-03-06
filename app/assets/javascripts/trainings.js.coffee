Training = 
	availableDates : []
	showScheduleModal : ->
		callback = (response) ->
			for schedules in response.training_schedules			
				Training.availableDates.push(schedules.training_date)
			$(".date-picker").datepicker({beforeShowDay: Training.filterScheaduleDate, dateFormat: "dd-mm-yy"})
		$("#scheduleModal").modal('show')
		training_location_id = $(".schedule-section").attr("data-training-location")
		console.log(training_location_id)
		$.get "/training_schedules.json?training_location_id=#{training_location_id}", callback,'json'

	filterScheaduleDate : (date) ->			
		dmy =  date.getDate() + "-" + (date.getMonth() + 1)  + "-" + date.getFullYear()
		if $.inArray(dmy, Training.availableDates) != -1
			[true, "","Available"]
		else 
			[false,"","unAvailable"]

$ ->
	$('#select-schedule').click (e) -> 
		e.preventDefault
		Training.showScheduleModal()
		return false

$ ->
	$(".heading-title").click ->
		alert("test")