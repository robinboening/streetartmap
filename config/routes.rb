Rails.application.routes.draw do
  devise_for :users

  root 'locations#index'

  resources :locations, except: [:index, :destroy]

  namespace :api, defaults: {format: :json} do
    resources :locations
  end
end
