require('initialize')

App.setupForTesting()
App.injectTestHelpers()


App.TestingAdapter = DS.FixtureAdapter.extend                # This adapter has ability to search the fixtures not only on
# id but also on other properties which can be given as a query
# e.g sample = App.Sample.find({text:'abc'})
	simulateRemoteResponse: false
#	queryFixtures: (fixtures, query, type) ->
##		console.log query
##		console.log type
#		fixtures.filter (item) ->
#			for prop of query
#				unless item[prop] is query[prop]
##					console.log item[prop]
#					return false
#			true

App.ApplicationStore = DS.Store.extend
	adapter: App.TestingAdapter.create()

QUnit.module "Sample Tests",
	#The setup and teardown hooks will be called before and after each test that is defined below this module.
	setup: ->
		Ember.run App,->
			App.advanceReadiness()

	teardown: ->
		Ember.run App,->                                  # reset the application to undo any changes made during the test
			App.reset()


#Run tests using below commands:
# 1. run "brunch b -e test"
# 2. run "karma start"

