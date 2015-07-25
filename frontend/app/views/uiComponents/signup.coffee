App = require 'app'

App.SignupView = Em.View.extend
	templateName:'uiComponents/signup'
	didInsertElement:->
		App.AnimatedView(@)

	signupButtonClass:(->
		"ch-btn signupbutton floatLT"
	).property('controller.canSignup')

	setFocus:(->
		if @get('controller').get('hasAcceptedTerms')
			$('.checkbox-signup').focus()
	).observes('controller.hasAcceptedTerms')