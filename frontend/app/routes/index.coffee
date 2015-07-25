App = require 'app'

App.IndexRoute = Em.Route.extend
	beforeModel: ()->
		if @session.get('currentUser')
			@transitionTo 'home'
		else
			@transitionTo 'login'
