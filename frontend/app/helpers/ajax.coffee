#####################################################################
# Copyright (C) 2014 Navyug Infosolutions Pvt Ltd.
# Developer : Ranu Pratap Singh
# Email : ranu.singh@navyuginfo.com
# Created Date : 26/7/14
#####################################################################

#define all library methods here that will be used throughout the application
App = require 'app'

# writing ajax method so in case we need to put any ajax. This method should be used instead of plain
# jquery ajax. This will help keeping the code modular and ajax requests traceable.
App.ajax= (url, type, hash, context) ->
	if type.toLowerCase() isnt 'get' and hash.data isnt null
		hash.data = JSON.stringify(hash.data)
	hash.url = url
	hash.type = type
	hash.dataType = 'json'
	hash.contentType = 'application/json; charset=utf-8'
	hash.context = context || this
	$.ajax(hash)
