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
