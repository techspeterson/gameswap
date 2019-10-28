Rails.application.routes.draw do
  get "/users/:id", to: "users#show", as: "user"
  get "/users/:id/edit", to: "users#edit", as: "edit_user"
  put "/users/:id", to: "users#update"
  patch "/users/:id", to: "users#update"

  get "/listings", to: "listings#index", as: "listings"
  get "/listings/new", to: "listings#new", as: "new_listing"
  get "/listings/:id", to: "listings#show", as: "listing"
  get "/listings/:id/edit", to: "listings#edit", as: "edit_listing"
  post "/listings", to: "listings#create"
  put "/listings/:id", to: "listings#update"
  patch "/listings/:id", to: "listings#update"
  delete "/listings/:id", to: "listings#destroy"

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
end
