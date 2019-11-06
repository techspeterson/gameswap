Rails.application.routes.draw do
  get "/", to: "listings#index", as: "root"
  get "/dashboard", to: "user_profile#dashboard", as: "dashboard"
  get "/admin/dashboard", to: "user_profile#admin_dashboard", as: "admin_dashboard"

  get "/user_profile/:user_id", to: "user_profile#show", as: "user_profile"
  get "/user_profile/:user_id/listings", to: "user_profile#listings", as: "user_listings"

  get "/user_profile/:user_id/edit_profile", to: "user_details#edit", as: "edit_user_profile"
  patch "/user_profile/:user_id/edit_profile", to: "user_details#update", as: "user_detail"

  get "/user_profile/:user_id/add_address", to: "addresses#new", as: "new_address"
  post "/user_profile/:user_id/add_address", to: "addresses#create", as: "addresses"
  get "/user_profile/:user_id/edit_address", to: "addresses#edit", as: "edit_address"
  patch "/user_profile/:user_id/edit_address", to: "addresses#update", as: "address"
  delete "/user_profile/:user_id/edit_address", to: "addresses#destroy"

  post "/user_profile/:user_id/wishlist", to: "wishlist_items#create", as: "wishlist_items"
  delete "/user_profile/:user_id/wishlist/:wishlist_id", to: "wishlist_items#destroy", as: "remove_wishlist_item"

  get "/listings", to: "listings#index", as: "listings"
  get "/listings/search", to: "listings#search", as: "search"
  get "/listings/new", to: "listings#new", as: "new_listing"
  get "/listings/:id", to: "listings#show", as: "listing"
  get "/listings/:id/edit", to: "listings#edit", as: "edit_listing"
  post "/listings", to: "listings#create"
  put "/listings/:id", to: "listings#update"
  patch "/listings/:id", to: "listings#update"
  delete "/listings/:id", to: "listings#destroy"

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  get "/payments/success", to: "payments#success"
  post "/payments/webhook", to: "payments#webhook"
end
