#####################################################################
# Copyright (C) 2013 Navyug Infosolutions Pvt Ltd.
# Developer : Ranu Pratap Singh
# Email : ranu.singh@navyuginfo.com
# Created Date : 26/7/14
#####################################################################

App = require 'app'

App.SignupMixin = Em.Mixin.create
	canSignup: null

	canSignupUpdate: (->
		if !Ember.isEmpty(@get 'firstname') and !Ember.isEmpty(@get 'lastname') and !Ember.isEmpty(@get 'email') and !Ember.isEmpty(@get 'password') and !Ember.isEmpty(@get 'passwordCnfrm') and !Ember.isEmpty(@get('hasAcceptedTerms'))
			@set 'canSignup', true
		else
			@set 'canSignup', false
			@set 'alertMessage',"Please provide all details to sign up."
			return
		if !@get('isEmailValid')
			@set 'canSignup', false
			return
		if @get('password')
			if @get('password').toString().length < 8         #check for minimum length of user password
				@set 'canSignup', false
				@set 'alertMessage', "Password should be atleast 8 characters."
				return
		if @get('password') != @get('passwordCnfrm')          #check for password = confirmpassword
			@set 'canSignup', false
			@set 'alertMessage',"Password and Confirmation password do not match."
			return
		if !@get 'hasAcceptedTerms'
			@set 'canSignup', false
			@set 'alertMessage',"You have to agree to the terms and conditions in order to sign up."
			return
	).observes('firstname', 'lastname', 'password', 'passwordCnfrm', 'isEmailValid', 'hasAcceptedTerms')

	isEmailValid: (->
		App.isEmailValid(@get 'email')
	).property('email')

	actions:
		signup: ->
			self = @
			if @get 'canSignup'
				#All Validations have passed Time to hit the server with the user details.
				$('#signup-submit').attr('disabled','disabled')
				user = {}
				user.firstname = self.get('firstname')
				user.lastname = self.get('lastname')
				user.email = self.get('email')
				user.password = self.get('password')
				data = {user: user}
				request = $.ajax
					type: 'POST'
					url: App.CONSTANTS.SIGN_UP_URL
					dataType: 'json'
					data: data
				request.done (response)->
					if response.msg == 1
						self.showAlertNow('alert-success',
							'User has been created please confirm your account from the email you provided')
						self.getLoggedInAndSignIn()
					else
						if response.email
							errorMessage = 'Sorry this email ' + response.email[0]+'. Please sign up with a different email.'
							self.showAlertNow('alert-error', errorMessage)
						#						self.set('email', '')
						#						self.set('password', '')
						#						self.set('passwordCnfrm', '')
						$('#signup-submit').removeAttr('disabled')
				request.fail (jqXHR, textStatus, e)->
					console.log "Error Occurred" + e
			else
				if Ember.isEmpty(@get('canSignup'))
					self.showAlertNow('alert-error', 'Please provide all the details to sign up.')
					return
				self.showAlertNow('alert-error', @get('alertMessage'))

