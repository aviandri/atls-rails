AdminTraining = 
	processIdName : (obj, inputCount) ->
		oldId = obj.attr 'id'
		newId = oldId.replace(new RegExp(/_[0-9]+_/), "_#{inputCount}_")
		obj.attr 'id', newId

		oldName = obj.attr 'name'
		console.log("-----")
		console.log(oldName)
		newName = oldName.replace(new RegExp(/\[[0-9]+\]/), "[#{inputCount}]")
		obj.attr 'name', newName
$ ->
	$(document).ready ->
		if('.payment_input').length
			latestPaymentInput = $(".payment_input").last()
			formClone = latestPaymentInput.clone()
			latestPaymentInputCount = $(".payment_input").length
			latestPaymentInput.remove()
			

		$("#add_payment").click ->
			console.log("payment input" +$(".payment_input").length)
			newNestedForm = $(formClone).last().clone()

			inputCount = $(".payment_input").length

			$(newNestedForm).find('label').each ->
				oldLabel = $(this).attr 'for'
				newLabel = oldLabel.replace(new RegExp(/_[0-9]+_/), "_#{inputCount}_")
				$(this).attr 'for', newLabel

			newNestedForm.find('input').each ->			
				AdminTraining.processIdName($(this), inputCount)
			
			newNestedForm.find('select').each ->			
				AdminTraining.processIdName($(this), inputCount)

			if $(".payment_input").length > 0
				newNestedForm.insertAfter($(".payment_input").last())
			else
				$("#payments-container").append(newNestedForm)



		$('body').on 'click', ".destroy_duplicate_nested_form", (e) ->
    		$(this).closest('.payment_input').slideUp().remove()



