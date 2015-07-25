#####################################################################
# Copyright (C) 2013 Navyug Infosolutions Pvt Ltd.
# Developer : Ranu Pratap Singh
# Email : ranu.singh@navyuginfo.com
# Created Date : 26/7/14
#####################################################################

App = require 'app'

App.SigninMixin = Em.Mixin.create
	canLogin: false

	showAlertNow: (type, msg)->
		alert(msg)

	googleLoginSuccess: (data)->
		if data.status!='error'
			App.set('user', data)
		else
			@showAlertNow('alert-error', "Login with google failed. Please try manual login.")

	facebookLoginSuccess: (data)->
		if data.status!='error'
			App.set('user', data)
		else
			@showAlertNow('alert-error', "Login with facebook failed. Please try manual login.")

	linkedInLoginSuccess: (data)->
		if data.status!='error'
			App.set('user', data)
		else
			@showAlertNow('alert-error', "Login with linkedin failed. Please try manual login.")

	canLoginUpdate: (->
		if !Ember.isEmpty(@get 'emailLogin') and !Ember.isEmpty(@get 'passwordLogin')
			@set 'canLogin', true
		if !@get 'isLoginEmailValid'
			@set 'canLogin', false
		if @get 'passwordLogin'
			if @get('passwordLogin').toString().length < 8
				@set 'canLogin', false
	).observes('isLoginEmailValid', 'passwordLogin')

	isLoginEmailValid: (->
		App.isEmailValid(@get 'emailLogin')
	).property('emailLogin')

	getLoggedInAndSignIn: ()->
		self = @
		$.ajax
			type: 'GET'
			url: App.CONSTANTS.LOGGED_IN_USER_URL
			success: (data)->
				if data['message'] != 'Nobody logged In'
					App.set('user',data.user)
				$('#loginModal').modal('hide')

	linkedinLoginCallback: () ->
		self = @
		$.ajax
			url:'/users/auth/linkedinLogin'
			type:'post'
			success: self.linkedInLoginSuccess

	linkedinFrameworkLoaded: () ->
		IN.UI.Authorize().place()

	twitterLoginComplete: (status)->
		self = @
		if status == 'success'
			self.getLoggedInAndSignIn()
		else
			self.showAlertNow('alert-error',"Login with twitter failed. Please try manual login.")

	linkedinLoginComplete: (status)->
		self = @
		if status == 'success'
			self.getLoggedInAndSignIn()
		else
			self.showAlertNow('alert-error',"Login with linkedin failed. Please try manual login.")

	actions:
		login: ->
			self = @
			if @get 'canLogin'
				credentials = {}
				user = {}
				user.email = self.get('emailLogin')
				user.password = self.get('passwordLogin')
				credentials.user = user

				request = $.ajax
					type: 'POST'
					url: App.CONSTANTS.SIGN_IN_URL
					data: credentials
				request.done (response)->
					if response.message == "Sign in successful"
						self.getLoggedInAndSignIn()
					else
						self.showAlertNow('alert-error', response.message)
			else
				self.showAlertNow('',
					"It seems you have missed some fields.Please make sure all the above fields are filled and correct.")

	# go to https://developers.facebook.com/apps/ and create an app
	# copy client id in constant.coffee
		facebooklogin: ->
			if window.fbLoaded
				self = @
				FB.init
					appId: App.CONSTANTS.FACEBOOK_APP_ID
					status: true
					cookie: true
					xfbml: true

				FB.login (response)->
					if response.status=='connected'
						$.ajax
							url:'/users/auth/facebook'
							type:'post'
							data:
								access_token: response.authResponse.accessToken
							success: self.facebookLoginSuccess
				,scope: 'email'

		linkedinlogin: ->
			if window.linkedInLoaded
				self = @
				IN.Event.on(IN, 'frameworkLoaded',self.linkedinFrameworkLoaded,self)
				IN.Event.on(IN, 'auth',self.linkedinLoginCallback,self)

		googlelogin: ->
			if window.gapiLoaded
				self=this
				scope = 'email'
				user={}
				gapi.auth.signIn
					callback: (result)->
						$.ajax
							url:'/users/auth/google'
							type:'post'
							data:
								access_token:result.access_token
							success: self.googleLoginSuccess

		twitterlogin: ->
			twitterWindow = window.open("/users/auth/twitterLogin","twitterAuthWindow","menubar=0,toolbar=0, status=0, location=0, resizable=0, width=750, height=550");
			twitterWindow.moveTo(300, 300)

		linkedinOmniAuthLogin: ->
			twitterWindow = window.open("/auth/linkedin","linkedinAuthWindow","menubar=0,toolbar=0, status=0, location=0, resizable=0, width=750, height=550");
			twitterWindow.moveTo(300, 300)
