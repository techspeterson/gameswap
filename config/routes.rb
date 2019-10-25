Rails.application.routes.draw do
  get 'listings/index'
  get 'listings/show'
  get 'listings/new'
  get 'listings/edit'
  get 'listings/create'
  get 'listings/update'
  get 'listings/destroy'
  devise_for :users
  root to: "home#index"
end
