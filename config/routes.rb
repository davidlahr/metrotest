Rails.application.routes.draw do
  
  resources :companies

  devise_scope :user do
    # get "users", to: "registrations#index"
    # get "users/new", to: "registrations#admin_new"
    # get "users/:id/edit", to: "registrations#edit", as: :user
    # patch "users/:id/edit", to: "registrations#update"
    # post "users/:id/edit", to: "registrations#update"

  end
  
  devise_for :users, :controllers => {:registrations => "registrations"}
  # devise_for :users
  
  resources :users
  
  
  
  resources :metro_files do
    resources :instances, only:[:index, :show, :metric]
    get "metric", to:'instances#metric'
    get "minors", to:'instances#minors'
    get "disputes", to:'instances#disputes'
    get "comments", to:'instances#comments'  
    get "invalid_ssns", to:'instances#invalid_ssns'
    get "medical_states", to:'instances#medical_states'
    get "medical_balance", to:'instances#medical_balance'
    get "missing_names", to: 'instances#missing_names'
    get "no_dob_or_ssns", to: 'instances#no_dob_or_ssns'
    get "bad_dofds", to: 'instances#bad_dofds'  
  end
    
  


  get "metrofile", to: "metro_files#new_import"
  post "metrofile", to: "metro_files#import"
  # get "instances", to: "instances#index"
  get "instance", to: "instances#show"
  
  
  # get "file", to: "instances#new_import"
  # post "file", to: "instances#import"
  
  
  
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "metro_files#index"
end
