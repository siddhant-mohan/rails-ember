#####################################################################
# Copyright (C) 2014 Navyug Infosolutions Pvt Ltd.
# Developer : Ranu Pratap Singh
# Email : ranu.singh@navyuginfo.com
# Created Date : 26/7/14
#####################################################################

# Application bootstrapper
config =
	LOG_TRANSITIONS: true,
	LOG_TRANSITIONS_INTERNAL: false
	#rootElement: '#qunit-fixture'          #comment this line to run tests using karma

App= Ember.Application.create(config)

Session = Ember.Object.extend
	isAuthenticated: false
	currentUser: null

# registering session factory. This will inject a session object in each route and controller
App.register('session:main', Session);
App.inject('controller', 'session', 'session:main');
App.inject('route', 'session', 'session:main');

module.exports = App
