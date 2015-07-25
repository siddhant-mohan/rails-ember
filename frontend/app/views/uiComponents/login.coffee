App = require 'app'

App.AnimatedView = (self,time) ->
	self.$().css('opacity',0)
	if time
		self.$().animate({opacity:1},time)
	else
		self.$().animate({opacity:1},1000)

App.LoginView = Ember.View.extend
	templateName:'uiComponents/login'
	didInsertElement:->
		App.AnimatedView(@)

	loginButtonClass:(->
		"ch-btn loginbutton floatLT"
	).property('controller.canLogin')

