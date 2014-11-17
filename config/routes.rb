Rails.application.routes.draw do
  root 'locations#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users
  resources :locations, only: [:show, :index, :new]

  namespace :api, defaults: {format: :json} do
    resources :locations
  end
end
