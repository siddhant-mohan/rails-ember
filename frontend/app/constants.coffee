App = require 'app'

App.CONSTANTS =
	HOST: 'http://localhost:3000'
#	GOOGLE_CLIENT_ID: "154893848799-6gjhimkbeu5nvr336pr8kaiku7mu9j02.apps.googleusercontent.com"
#	FACEBOOK_APP_ID: '267182603462991'
#	LINKEDIN_APP_KEY: '75291j3don9dv6'


App.CONSTANTS.LOGOUT_URL = App.CONSTANTS.HOST + '/sign_out'
App.CONSTANTS.LOGGED_IN_USER_URL = App.CONSTANTS.HOST + '/users/logged_in'
App.CONSTANTS.SIGN_IN_URL = App.CONSTANTS.HOST + "/users/sign_in"
App.CONSTANTS.SIGN_UP_URL = App.CONSTANTS.HOST + "/users/sign_up"
App.CONSTANTS.FORGOT_PASSWORD_URL = App.CONSTANTS.HOST + '/users/forgot_password'
App.CONSTANTS.RESET_PASSWORD_URL = App.CONSTANTS.HOST + '/auth/password'
App.CONSTANTS.CHANGE_PASSWORD_URL = App.CONSTANTS.HOST + '/users/change_password'

