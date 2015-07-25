# Please refer to "http://emberjs.com/guides/testing" and subsequent links to
# know more about testing different parts of the application

test 'application layout partials', ->
	ok App, 'Application Instance exist'
	ok Ember.TEMPLATES['application'], 'application template exists'
