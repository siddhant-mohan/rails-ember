
App = require 'app'

App.LoginmodalController = Em.Controller.extend App.AlertMixin, App.ChangePasswordMixin, App.SignupMixin,
	App.ForgotPasswordMixin, App.SigninMixin,

#Resets the controller properties. Needed on every new modal load.
	reset: ->
		@set 'firstname', `undefined`
		@set 'lastname', `undefined`
		@set 'email', `undefined`
		@set 'password', `undefined`
		@set 'oldPassword', `undefined`
		@set 'newPassword', `undefined`
		@set 'confirmPassword', `undefined`
		@set 'passwordCnfrm', `undefined`
		@set 'emailLogin', `undefined`
		@set 'passwordLogin', `undefined`
		@set 'hasAcceptedTerms', `undefined`
		@set 'showAlert', false
		@set 'alertMessage', ""
		@set 'alertType', ""
		@set 'processing',false

#These properties are to implement the validations and restricting the user from signing in or signing up without providing
#valid credentials.
	showChngPsswrd: false
	processing:false

	googleLoginSuccess: (data)->
		if data.status!='error'
			App.set('user', data)
			$('#loginModal').modal('hide')
		else
			self.showAlertNow('alert-error', "Login with google failed. Please try manual login.")

	facebookLoginSuccess: (data)->
		if data.status!='error'
			App.set('user', data)
			$('#loginModal').modal('hide')
		else
			self.showAlertNow('alert-error', "Login with facebook failed. Please try manual login.")

	linkedInLoginSuccess: (data)->
		if data.status!='error'
			App.set('user', data)
			$('#loginModal').modal('hide')
		else
			@showAlertNow('alert-error', "Login with linkedin failed. Please try manual login.")
