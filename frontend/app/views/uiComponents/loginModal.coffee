#####################################################################
# Copyright (C) 2013 Navyug Infosolutions Pvt Ltd.
# Developer : Dhruv Parmar
# Email : dhruvparmar@gmail.com
# Created Date : 19-Aug-2013
#####################################################################

App = require 'app'

App.LoginmodalView = Ember.View.extend(Ember.ViewTargetActionSupport,
	templateName:'uiComponents/loginmodal'
	action:'hideModal'
	didInsertElement: ->
#		@get('controller').reset()                #reset the controller properties to disable persisting of previous details
		self = @
		$('#loginModal').modal(
			keyboard:false
			show:true
		).on('hidden',->
			self.triggerAction()
		)
	modalhide:()->
		$('#loginModal').modal('hide')
)
