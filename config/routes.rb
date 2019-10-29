Rails.application.routes.draw do
  get "/users/:user_id", to: "users#show", as: "user"

  scope format: false do
    get "/my_profile", to: "users#my_profile", as: "my_profile"

    get "/my_profile/edit_profile", to: "user_details#edit", as: "edit_user_profile"
    patch "/my_profile/edit_profile", to: "user_details#update", as: "user_detail"

    get "/my_profile/add_address", to: "addresses#new", as: "new_address"
    post "/my_profile/add_address", to: "addresses#create", as: "addresses"
    get "/my_profile/edit_address", to: "addresses#edit", as: "edit_address"
    patch "/my_profile/edit_address", to: "addresses#update", as: "address"
    delete "/my_profile/edit_address", to: "addresses#destroy"

    post "/my_profile", to: "wishlist_items#add_item", as: "wishlist_items"
    delete "/my_profile/:wishlist_id", to: "wishlist_items#remove_item", as: "remove_wishlist_item"
  end

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
