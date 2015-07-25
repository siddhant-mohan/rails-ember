App = require("app")

App.ApplicationStore = DS.Store.extend
	adapter: DS.ActiveModelAdapter.extend
		host: App.CONSTANTS.HOST
