Rails.application.routes.draw do

  # Auto-generated from scaffolding
  resources :visits
  resources :start_ats
  resources :locations
  resources :photos
  resources :reviews
  resources :waitlists
  resources :bookings
  resources :bookmarks
  resources :listings
  resources :tours
  resources :users

  # Support login
  # Per https://www.railstutorial.org/book/basic_login
  # Route the incoming request (left) to controller action (right)
  get     '/login',     to: 'sessions#new'
  post    '/login',     to: 'sessions#create'
  delete  '/logout',    to: 'sessions#destroy'

  # Support redirecting waitlist update to booking update
  # to avoid duplicated code (booking update already has all the smarts)
  get     '/reroute_waitlist_update', to: 'bookings#update'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Home page
  root 'sessions#new'

end
