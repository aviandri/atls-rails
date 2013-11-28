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
				oldId = $(this).attr 'id'
				console.log(oldId)
				newId = oldId.replace(new RegExp(/_[0-9]+_/), "_#{inputCount}_")
				console.log(newId)
				$(this).attr 'id', newId


				oldName = $(this).attr 'name'
				newName = oldName.replace(new RegExp(/\[[0-9]+\]/), "[#{inputCount}]")
				$(this).attr 'name', newName

			
			if $(".payment_input").length > 0
				newNestedForm.insertAfter($(".payment_input").last())
			else
				$("#payments-container").append(newNestedForm)



		$('body').on 'click', ".destroy_duplicate_nested_form", (e) ->
    		$(this).closest('.payment_input').slideUp().remove()
