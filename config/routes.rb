AtlsRails::Application.routes.draw do
  root :to => 'high_voltage/pages#show', :id => 'index'
  devise_for :attendees, :controllers => { 
    :registrations => "attendees"}

  devise_scope :attendee do
    get '/attendees/new' => "attendees#new", :as => "sign_up"
  end

  resources :attendees

  get "profiles/index"

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :blogs
  
  resources :orders

  resources :pretests

  resources :test_results

  resources :trainings

  resources :training_schedules, :only => [:index]

  match "/home" => "homes#index"
  match "/home/test" => "homes#test"
  match "/home/start_test" => "homes#start_test"
  match "/home/finish_test" => "homes#finish_test"

  match "/payment_term" => "homes#payment_terms"

  match "/payment_code" => "orders#payment_code"

end
