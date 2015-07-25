require 'app'

App.PasswordEditController = Ember.Controller.extend App.AlertMixin,
	queryParams: ['reset_password_token']
	reset_password_token: null
	passwd: null
	confirmPasswd: null
	actions:
		resetPasswd:()->
			passwd = @get 'passwd'
			c_passwd = @get 'confirmPasswd'
			unless passwd is c_passwd
				return @showAlertNow('alert-error', 'passwords dont match')

			url = App.CONSTANTS.RESET_PASSWORD_URL
			type = 'PATCH'
			hash = {
				data:{
					reset_password_token: @get 'reset_password_token'
					password: passwd
					confirm_password: c_passwd
				}
				success: (responseJSON)->
					msg = responseJSON.message || 'Password reset.'
					@showAlertNow('alert-success', msg)
				error: (jqXhr)->
					msg = jqXhr.responseJSON.message || 'Could not reset password.'
					@showAlertNow('alert-error', msg)
			}
			App.ajax url, type, hash, this

