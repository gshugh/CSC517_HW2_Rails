Rails.application.routes.draw do

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

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'users#index'

end
