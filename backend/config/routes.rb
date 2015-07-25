Backend::Application.routes.draw do
	devise_for :users, path: 'auth', controllers: {
			confirmations: 'users/confirmations',
			passwords: 'users/passwords',
			registrations: 'users/registrations',
			sessions: 'users/sessions',
	}
	# The priority is based upon order of creation: first created -> highest priority.
	# See how all your routes lay out with "rake routes".

	#For setting routes devise_scope must be used
	devise_scope :user do
		get 'sign_out' => 'users/sessions#destroy'
		get 'sign_in' => 'users/sessions#new'
		get 'sign_up' => 'users/registrations#new'
	end

	# You can have the root of your site routed with "root"
	root 'home#index'

	post '/users/sign_up' => 'users#user_signup'
	get '/users/logged_in' => 'users#loggedin_user'
	post '/users/sign_in' => 'users#user_signin'
	post '/users/change_password' => 'users#change_password'
	post '/users/forgot_password' => 'users#forgot_password_user'
	get 'users/resend_confirmation' => 'users#resend_confirmation'

	post 'users/auth/facebook' => 'users#facebook'
	post 'users/auth/google' => 'users#google'
	post 'users/auth/linkedinLogin' => 'users#linkedin'
	get 'users/auth/twitterLogin' => 'users#twitter'


	#omniauth login
	get "/auth/linkedin/callback" => "users#linkedin_callback"

	get "/auth/twitter/callback" => "users#twitter_callback"
	post "/auth/twitter/email_twitter_callback" => "users#email_twitter_callback"

	# capturing all ember routes below
	get '/home(/*whatever)' => 'home#index'
end
