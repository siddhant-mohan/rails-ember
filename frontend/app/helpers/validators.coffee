#####################################################################
# Copyright (C) 2014 Navyug Infosolutions Pvt Ltd.
# Developer : Ranu Pratap Singh
# Email : ranu.singh@navyuginfo.com
# Created Date : 26/7/14
#####################################################################

App = require 'app'

# Improve Email validations Better RegEX
App.isEmailValid = (email)->
	emailRegEx = new RegExp(/^((?!\.)[a-z0-9._%+-]+(?!\.)\w)@[a-z0-9-]+\.[a-z.]{1,5}(?!\.)\w$/i)
	emailRegEx.test(email)
