#####################################################################
# Copyright (C) 2014 Navyug Infosolutions Pvt Ltd.
# Developer : Ranu Pratap Singh
# Email : ranu.singh@navyuginfo.com
# Created Date : 26/7/14
#####################################################################

App = require 'app'

App.IndexRoute = Em.Route.extend
	beforeModel: ()->
		if @session.get('currentUser')
			@transitionTo 'home'
		else
			@transitionTo 'login'
