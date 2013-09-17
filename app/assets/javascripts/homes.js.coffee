# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
Home = 
	showModal : (pendingOrders)->	
		if pendingOrders.count == 0	
			$("#myModal").modal('show') 
		else
			alert("You have pending orders already! Please finish the payment of cancel it first")

	availableDates : []

	showScheduleModal : ->
		callback = (response) ->
			for schedules in response.training_schedules			
				Home.availableDates.push(schedules.training_date)
			$("#date-picker").datepicker({beforeShowDay: Home.filterScheaduleDate, dateFormat: "dd-mm-yy"})
		$("#scheduleModal").modal('show')
		$.get '/training_schedules.json', callback,'json'
	
	
	filterScheaduleDate : (date) ->			
		dmy =  date.getDate() + "-" + (date.getMonth() + 1)  + "-" + date.getFullYear()
		if $.inArray(dmy, Home.availableDates) != -1
			[true, "","Available"]
		else 
			[false,"","unAvailable"]

$ ->
	$('#register-button').click ->		
		callback = (response) -> 
			Home.showModal(response)
			false

		$.get '/orders.json?status=pending', callback,'json'


$ ->
	$('#schedule-button').click ->
		Home.showScheduleModal()

$ ->
	$('#detail-button').click ->
		$("#bankAccountModal").modal('show')
				
$ ->
	$("#payment-term").change ->
		callback = (response) ->
			$("#payment-code").text("Rp."+response.payment_code+",-")
			amount = $("#payment-term :selected").attr("data-amount")
			totalAmount = parseInt(amount) + parseInt(response.payment_code)
			$("#payment-amount").text("Rp."+amount+",-")
			$("#attendee_orders_attributes_0_payment_amount").attr("value", amount)
			$("#attendee_orders_attributes_0_payment_code").attr("value", response.payment_code)
			$("#payment-total").text("Rp."+totalAmount+",-")
			$("#price-section").show()

		$.get '/payment_code', callback, 'json'

$ ->
	$("#training_location").change ->
		callback = (response) ->
			console.log(response.payment_term)
			for payterm in response.payment_term
				$("#payment-term").append($("<option></option>")
					.attr("data-amount",payterm.price)
					.text(payterm.name))
		
		$.get '/payment_term.json?training_location_id='+$("#training_location").val(), callback, 'json'
class Pretest
	constructor : ->
		test = ''
		@currentIndex = 0
		testObject = ''
		@answer = []

	setObjects : (resource) ->
		@tests = resource

	getObject : ->
		@testObject = @tests[@currentIndex]		
	getNextObject :  ->
		@currentIndex++
		console.log("current index")
		console.log(@currentIndex)
		@testObject = @tests[@currentIndex]		
	getPrevObject :  ->
		currentIndex--
		@testObject = @tests[@currentIndex]		
	getQuestion : ->
		console.log @testObject
		@testObject.pretest.question
	getAnswer1 : ->
		@testObject.pretest.answer_one	
	getAnswer2 : ->
		@testObject.pretest.answer_two
	getAnswer3 : ->
		@testObject.pretest.answer_three
	getAnswer4 : ->
		@testObject.pretest.answer_four
	getAnswers : ->
		@answer
	getId : ->
		@testObject.pretest.id
	setAnswer : (id, ans) ->
		@answer[id] = ans
	isLast : ->		
		true if @currentIndex == @tests.length - 1
	isFirst : ->		
		true if @currentIndex == 0
	getCurrentIndex : ->
		@currentIndex

Test = 
	populateElement : () ->
		$("#question").html(pretest.getQuestion())
		$("#answer1").html(pretest.getAnswer1())
		$("#answer2").html(pretest.getAnswer2())
		$("#answer3").html(pretest.getAnswer3())
		$("#answer4").html(pretest.getAnswer4())
		$("#question-section").attr("data-id", pretest.getId())				

	lastPageAction : () ->
		Test.showSubmitButton()
		Test.disableNextButton()

	showSubmitButton : () ->
		$('#submit').show()

	disableNextButton : () ->
		$('#next').attr('disabled', 'disabled')
			
	disablePrevButton : () ->
		$('#prev').attr('disabled', 'disabled')

	showNextButton : () ->
		$('#next').removeAttr('disabled')

	showPrevButton : () ->
		$('#prev').removeAttr('disabled')

	createAnswerJson : () ->
		json = {'answers' : []}
		for answer, i in pretest.getAnswers()
			istring = '' + i
			if answer != undefined			
				jsonAns = {'id' : istring, 'answer' : answer}
				json.answers.push(jsonAns)
		json

	updatePageIndex : () ->
		$("#indexCount").html(pretest.getCurrentIndex() + 1)

	submitAnswer : () ->
		json = Test.createAnswerJson()		
		callback = (response) ->
			window.location.replace("/home/finish_test")
		$.ajax '/test_results.json', type: 'POST', data: JSON.stringify(json), success: callback, contentType: "application/json", dataType: "json"		


  			
pretest = new Pretest

$ ->
	$('#start-test').click ->		
		window.location.replace("/home/start_test")

$ ->
	$('#next').click ->			
		Test.showPrevButton()
		answerValue = $('input[type=radio]:checked').val()
		questionId = $('#question-section').attr('data-id')
		pretest.setAnswer(questionId, answerValue)				
		if pretest.isLast()	
			console.log('isLast')
			Test.showSubmitButton()
			Test.disableNextButton()
		else
			pretest.getNextObject()
			Test.populateElement()
		Test.updatePageIndex()

$ ->
	$('#prev').click ->		
		pretest.getPrevObject()
		Test.populateElement()
		Test.updatePageIndex()
		Test.showNextButton()
		if pretest.isFirst()
			Test.disablePrevButton()

$ ->
	$('#submit').click ->
		Test.submitAnswer()		
		


$ ->
	$('#back-home').click ->	
		window.location.replace("/home")


$ ->
	$("#pretest-section").ready ->
			callback = (response) ->
				console.log('response')
				console.log(response.length)
				pretest.setObjects(response)
				pretest.getObject()
				Test.populateElement()
				Test.disablePrevButton()
				false
			$.get '/pretests.json?random=true', callback, 'json'		
			false


$ ->
	$('#test-button').click ->	
		window.location.replace("/home/test")
















	



