#####################################################################
# Copyright (C) 2013 Navyug Infosolutions Pvt Ltd.
# Developer : Ranu Pratap Singh
# Email : ranu.singh@navyuginfo.com
# Created Date : 26/7/14
#####################################################################

App = require 'app'

App.ChangePasswordMixin = Em.Mixin.create

	changePasswordSuccess : (response)->
		alertMessageType = ""
		if response == 'Password change successful. Please login again with new password.'
			alertMessageType = 'alert-success'
		if (response == 'There was some error on our side. Please try again later.') or (response == "It seems you entered the wrong old password")
			alertMessageType = 'alert-error'
		@showAlertNow(alertMessageType, response)

	validateChangePassword: ->
		if (Ember.isEmpty(@get('oldPassword')) or Ember.isEmpty(@get('confirmPassword')) or Ember.isEmpty(@get('newPassword')))
			@changePasswordSuccess("It seems you have left some fields empty.")
			return false
		if @get('newPassword.length') < 8
			@changePasswordSuccess("Password length should be greater than or equal to 8")
			return false
		if @get('newPassword') == @get('oldPassword')
			if !confirm('You have entered same new password and Old Password.Are you sure?')
				@changePasswordSuccess("You have entered same new password and Old Password.")
				return false
			else
				return true
		if @get('newPassword') != @get('confirmPassword')
			@changePasswordSuccess("New password and confirm password dont match")
			return false
		return true

	changePassword: ->
		if !@validateChangePassword()
			return

		self= this
		$.ajax
			'url': App.CONSTANTS.CHANGE_PASSWORD_URL
			'type': 'POST'
			'data':
				'user':
					'id': App.get('user.id')
					'oldPassword': self.get('oldPassword')
					'newPassword': self.get('newPassword')
			'success': (response)->
				self.set 'notice', response.status
				self.changePasswordSuccess(response.status)
				if response.status == "Password change successful. Please login again with new password."
					App.set('user', `undefined`)

