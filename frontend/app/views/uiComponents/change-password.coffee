App = require 'app'

App.ChangePasswordView = Em.View.extend
	templateName:'uiComponents/change-password'
	didInsertElement:->
		App.AnimatedView(@)

	signupButtonClass:(->
		"ch-btn signupbutton floatLT"
	).property('controller.canSignup')

	setFocus:(->
		if @get('controller').get('hasAcceptedTerms')
			$('.checkbox-signup').focus()
	).observes('controller.hasAcceptedTerms')