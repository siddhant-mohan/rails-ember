App = require 'app'

App.ApplicationRoute = Ember.Route.extend
	beforeModel: ->
#		Before the model hook is called we will query the backend for current_user. If it exists then we will set our Application's
#		user to that user. Otherwise we will wait for user sign in or sign up.
		if Ember.isEmpty(Ember.testing)          # remove this line when deploying int production mode.
			$.ajax
				type: 'GET'
				dataType: "jsonp"
				url: App.CONSTANTS.LOGGED_IN_USER_URL
				success: (data)->
					if data['message'] != 'Nobody logged In'
						App.set('user', data.user)

	actions:
		loginClick: ->
			@render 'loginmodal', {into: 'application', outlet: 'login_modal'}
		hideModal: ->
			@.disconnectOutlet
				outlet: 'login_modal'
				parentView: 'application'
		logout: ->
			$.ajax
				type: 'GET'
				url: App.CONSTANTS.LOGOUT_URL
				success: ()->
					App.set('user', undefined)
					location.reload()