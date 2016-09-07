NinetyNineCatsDay1::Application.routes.draw do
  resources :cats, except: :destroy
  resource :session, only: [:new, :create, :destroy]
  resources :cat_rental_requests, only: [:create, :new] do
    post "approve", on: :member
    post "deny", on: :member
  end
  resources :users, only: [:new, :create]
  root to: redirect("/cats")
end
