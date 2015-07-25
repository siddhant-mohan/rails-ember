#####################################################################
# Copyright (C) 2013 Navyug Infosolutions Pvt Ltd.
# Developer : Ranu Pratap Singh
# Email : ranu.singh@navyuginfo.com
# Created Date : 26/7/14
#####################################################################

App = require 'app'

# The routes which require authentication should extend this route. If such route overrides
# before model hook, it must call super to maintain the authentication check
App.AuthenticatedRoute = Em.Route.extend
	beforeModel:->
		@_super.apply this, arguments		# making default beforeModel hook run
		current_user = @get('session.currentUser')
		unless current_user
			@transitionTo('login')
