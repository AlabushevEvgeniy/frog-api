Rails.application.routes.draw do
  devise_for :admins, ActiveAdmin::Devise.config
  devise_for :users

  # mount GrapeSwaggerRails::Engine => '/swagger'
  mount API::Base, at: '/api'
  mount GrapeSwaggerRails::Engine, at: '/api/v1'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
