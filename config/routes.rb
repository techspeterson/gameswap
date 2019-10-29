Rails.application.routes.draw do
  get "/users/:id", to: "users#show", as: "user"
  post "/users/:id", to: "users#add_wishlist_item", as: "wishlist_items"
  delete "/users/:id/:wishlist_id", to: "users#remove_wishlist_item", as: "remove_wishlist_item"
  get "/users/:id/edit_profile", to: "users#edit_profile", as: "edit_user_profile"
  patch "/users/:id/edit_profile", to: "users#update_profile", as: "user_detail"
  get "/users/:id/edit_address", to: "users#edit_address", as: "edit_address"
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
