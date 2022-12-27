Rails.application.routes.draw do
  root("pages#home")
  get("about", to: "pages#about")
  # posts/1/comments/3
  get("search", to: "search#index")
  resources(:posts) do
    resources :comments
  end
  get("users/profile")
  devise_for(:users, controllers: { sessions: "users/sessions", registrations: "users/registrations" })
  get("u/:id", to: "users#profile", as: "user")
end
