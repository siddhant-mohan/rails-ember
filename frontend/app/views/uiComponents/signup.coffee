#####################################################################
# Copyright (C) 2013 Navyug Infosolutions Pvt Ltd.
# Developer : Dhruv Parmar
# Email : dhruvparmar@gmail.com
# Created Date : 19-Aug-2013
#####################################################################

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