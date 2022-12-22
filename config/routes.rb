Rails.application.routes.draw do
  resources :posts
  root("pages#home")
  get("about", to: "pages#about")
  devise_for(:users, controllers: { sessions: "users/sessions", registrations: "users/registrations" })
end
