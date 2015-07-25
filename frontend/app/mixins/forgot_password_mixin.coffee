App = require 'app'

# controller would include this mixin to show the alert messages
# `alert_message` partial must also be included in the corresponding template
App.ForgotPasswordMixin = Em.Mixin.create

	forgotpassword: ()->
		self = @
		$('#forgot-password-btn').attr("disabled","disabled")
		if self.get('emailLogin') and App.isEmailValid(self.get('emailLogin'))
			data={}
			data.email = self.get 'emailLogin'
			self.set('processing',true)
			$.ajax
				type: 'POST'
				url: App.CONSTANTS.FORGOT_PASSWORD_URL
				data: data
				success: (response)->
					alertTypeMessage = ""
					self.set('processing',false)
					$('#forgot-password-btn').removeAttr("disabled")
					if response.message == 'User does not exist.'
						alertTypeMessage = "alert-error"
					else
						alertTypeMessage = "alert-success"
					self.showAlertNow(alertTypeMessage, response.message)
				error:(response)->
					self.set('processing',false)
					$('#forgot-password-btn').removeAttr("disabled")
		else
			self.showAlertNow('alert-error', "Please make sure you provide the correct email address")
			$('#forgot-password-btn').removeAttr("disabled")

