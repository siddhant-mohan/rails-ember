App = require("app")

App.Router.map ->
	@route 'login', {path: '/sign_in'}
	@resource 'home'

	@route 'passwordEdit', {path: '/auth/password/edit'}


App.Router.reopen
	location: 'history'
