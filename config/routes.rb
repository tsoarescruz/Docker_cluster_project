require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web => '/admin/sidekiq'

  # Custom search action
  get '/admin/search_results/search/new' => 'admin/search_results#search', as: :search_admin_search_results
end
