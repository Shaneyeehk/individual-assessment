Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "static#home"

  resources :articles, except: :root
 
  get '/user-articles' => "articles#user_articles"
  # post '/checkemail' => 'users#emailcheck'

  resources :users, except: :root

  # Sign in and Sign out routes
  post '/sign-in' => "users#sign_in"
  get '/sign-out' => "users#sign_out"

  # Facebook login
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
 
  # Google Login
  get "/auth/google_oauth2" => "sessions#login"

end







  # resources :users, except: :root do 
  	# resources :sessions, only: [:new, :create, :destroy]
  # end
