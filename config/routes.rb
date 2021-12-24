Rails.application.routes.draw do
  post "posts/create" => "posts#create"
  get "posts/new" => "posts#new"
  get 'posts/index'

  
  post "logout" => "users#logout"
  post "/login" => "users#login"
  get "login" => "users#login_form"
  post "users/:id/update" => "users#update"
  get "users/:id/edit" => "users#edit"
  post "users/create" => "users#create"
  get 'users/index'
  get "users/:id" => "users#show"

  
  get "/" => "home#top"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
