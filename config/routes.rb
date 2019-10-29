Rails.application.routes.draw do
  get "/users/:id", to: "users#show", as: "user"

  get "/users/:id/edit_profile", to: "user_details#edit_profile", as: "edit_user_profile"
  patch "/users/:id/edit_profile", to: "user_details#update_profile", as: "user_detail"

  get "/users/:id/add_address", to: "addresses#new_address", as: "new_address"
  post "/users/:id/add_address", to: "addresses#create_address", as: "addresses"
  get "/users/:id/edit_address", to: "addresses#edit_address", as: "edit_address"

  post "/users/:id", to: "wishlist_items#add_item", as: "wishlist_items"
  delete "/users/:id/:wishlist_id", to: "wishlist_items#remove_item", as: "remove_wishlist_item"

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
