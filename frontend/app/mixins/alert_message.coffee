#####################################################################
# Copyright (C) 2013 Navyug Infosolutions Pvt Ltd.
# Developer : Ranu Pratap Singh
# Email : ranu.singh@navyuginfo.com
# Created Date : 26/7/14
#####################################################################

App = require 'app'

# controller would include this mixin to show the alert messages
# `alert_message` partial must also be included in the corresponding template
App.AlertMixin = Em.Mixin.create
	showAlert: false           #This value shows or hides the alert box in the template.
	alertType: ""              #This value takes care of adding the proper class to alert box to get the desired color.
	alertMessage: ""           #The message to show when any validations fail.

	showAlertObs: (->
		$('#alertBox').attr('class', 'alert')
		self = @
		alertClass = self.get 'alertType'
		self.set('alertType', '')
		if @get('showAlert')?
			Ember.run.next ->
				$('#alertBox').addClass(alertClass)
				$('#alertBox').css('opacity', 0)
				$('#alertBox').animate
					opacity: 1
				, 250
	).observes('showAlert', 'alertMessage')

	showAlertNow: (alertType, alertMessage)->
		@set('alertType', alertType)
		@set('showAlert', true)
		@set('alertMessage', alertMessage)

	hideAlert: ()->
		self = @
		$('#alertBox').css('opacity', 1)
		$('#alertBox').animate
			opacity: 0
		, 250
		, ()->
			self.set 'showAlert', false
