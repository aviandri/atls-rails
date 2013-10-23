require 'sidekiq/web'

AtlsRails::Application.routes.draw do
  root :to => 'high_voltage/pages#show', :id => 'index'
  devise_for :attendees, :controllers => { 
    :registrations => "attendees"}

  devise_scope :attendee do
    get '/attendees/new' => "attendees#new", :as => "sign_up"
  end


  get "profiles/index"

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :blogs
  
  resources :orders

  resources :pretests

  resources :test_results

  resources :training_schedules, :only => [:index]

  resources :trainings

  match "/home" => "homes#index"
  match "/home/test" => "homes#test"
  match "/home/start_test" => "homes#start_test"
  match "/home/finish_test" => "homes#finish_test"

  match "/home/profile/:id" => "homes#edit_profile", via: :get
  
  match "/home/profile/:id" => "homes#update_profile", via: :put

  match "/home/profile/:id/change_password" => "homes#change_password", via: :get

  match "/home/profile/:id/change_password" => "homes#update_password", via: :put

  match "/payment_term" => "homes#payment_terms"

  match "/payment_code" => "orders#payment_code"

  mount Sidekiq::Web => '/sidekiq'

end
