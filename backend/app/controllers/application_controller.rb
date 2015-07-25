class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
	#protect_from_forgery with: :null_session
	after_filter :cors_set_access_control_headers
	before_filter :cors_preflight_check
	skip_before_filter :verify_authenticity_token
	# For all responses in this controller, return the CORS access control headers.

	def cors_set_access_control_headers
		headers['Access-Control-Allow-Origin'] = '*'
		headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
		headers['Access-Control-Request-Method'] = '*'
		headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
	end

	def cors_preflight_check
		if request.method == :options
			headers['Access-Control-Allow-Origin'] = '*'
			headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
			headers['Access-Control-Allow-Headers'] = '*'
			headers['Access-Control-Max-Age'] = '1728000'
		end
	end
end
