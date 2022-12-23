Rails.application.routes.draw do
  get "users/profile"
  resources :posts
  root("pages#home")
  get("about", to: "pages#about")
  devise_for(:users, controllers: { sessions: "users/sessions", registrations: "users/registrations" })
  get("u/:id", :to => "users#profile", :as => "user")
end
