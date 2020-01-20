Rails.application.routes.draw do
  use_doorkeeper
  devise_for :admins, ActiveAdmin::Devise.config
  devise_for :users, path: 'api/v1/users'

  ActiveAdmin.routes(self)

  mount API::Base, at: '/api'
  mount GrapeSwaggerRails::Engine, at: '/documentation'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
