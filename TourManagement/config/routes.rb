Rails.application.routes.draw do

  # Auto-generated from scaffolding
  resources :visits
  resources :starts
  resources :locations
  resources :photos
  resources :reviews
  resources :waitlists
  resources :bookings
  resources :bookmarks
  resources :listings
  resources :tours
  resources :users

  # Supporting login
  # Per https://www.railstutorial.org/book/basic_login
  # Route the incoming request (left) to controller action (right)
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Home page
  root 'sessions#new'

end
