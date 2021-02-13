Rails.application.routes.draw do
  get "contacts/new", to: "contacts#new" 
  post "contacts/confirm", to: "contacts#confirm"
  post "contacts/complete", to: "contacts#complete"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  
  get "/registration", to: "users#new"
  resources :users, only: %i(index create destroy edit update) 


  root to: "notes#index"
  resources :notes

  #ネストして親子関係を明示
  resources :posts, only: %i(new create index show destroy) do
    resources :photos, only: %i(create)
    resources :likes, only: %i(create destroy)
    resources :comments, only: %i(create destroy)
  end
  get "/adminhome", to: "posts#home"
  get "/adminprofile", to: "posts#profile"
  
  

end
