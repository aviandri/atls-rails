# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
exports = this
exports.currentIndex = 0

Home = 
	showModal : (pendingOrders)->	
		if pendingOrders.count == 0	
			$("#myModal").modal('show') 
		else
			alert("You have pending orders already! Please finish the payment of cancel it first")


$ ->
	$('#register-button').click ->
		callback = (response) -> 
			Home.showModal(response)
			false
		$.get '/orders?status=pending', callback,'json'



class Pretest
	constructor : ->
		test = ''
		currentIndex = 0
		testObject = ''
		@answer = []

	setObjects : (resource) ->
		@tests = resource

	getObject : ->
		@testObject = @tests[currentIndex]		
	getNextObject :  ->
		currentIndex++
		@testObject = @tests[currentIndex]		
	getPrevObject :  ->
		currentIndex--
		@testObject = @tests[currentIndex]		
	getQuestion : ->
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
		console.log(@answer)
	isLast : ->		
		true if currentIndex == @tests.length - 1
	isFirst : ->		
		true if currentIndex == 0



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

$ ->
	$('#prev').click ->		
		pretest.getPrevObject()
		Test.populateElement()
		Test.showNextButton()
		if pretest.isFirst()
			Test.disablePrevButton()

$ ->
	$('#submit').click ->		
		json = Test.createAnswerJson()
		console.log json

		callback = (response) ->
			window.location.replace("/home/finish_test")
		$.ajax '/test_results.json', type: 'POST', data: JSON.stringify(json), success: callback, contentType: "application/json", dataType: "json"		


$ ->
	$('#back-home').click ->	
		window.location.replace("/home")


$ ->
	$("#pretest-section").ready ->
			callback = (response) ->
				pretest.setObjects(response)
				pretest.getObject()
				Test.populateElement()
				Test.disablePrevButton()
				false
			$.get '/pretests.json?random=true', callback, 'json'		
			false
















	



