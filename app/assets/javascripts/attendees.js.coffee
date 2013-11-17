$ -> 
	$(".date-picker").focus ->
		defaultDate = new Date("January 1, 1985");
		$(".date-picker").datepicker({dateFormat: "dd-mm-yy", defaultDate: defaultDate})

$ ->
	$(".date-picker").click ->
		$(".date-picker").focus()