Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  use_doorkeeper
  devise_for :users, path: 'api/v1/users'

  mount API::Base, at: '/api'
  mount GrapeSwaggerRails::Engine, at: '/documentation'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
