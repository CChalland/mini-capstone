Rails.application.routes.draw do
  
  post "/user_token" => "user_token#create"

  namespace :v1 do
    get "/products" => "products#index"
    post "/products" => "products#create"
    get "/products/:id" => "products#show"
    patch "/products/:id" => "products#update"
    delete "/products/:id" => "products#destroy"
    
    get "/suppliers" => "suppliers#index"
    post "/suppliers" => "suppliers#create"
    get "/suppliers/:id" => "suppliers#show"
    patch "/suppliers/:id" => "suppliers#update"
    delete "/suppliers/:id" => "suppliers#destroy"

    get "/images" => "images#index"
    post "/images" => "images#create"
    get "/images/:id" => "images#show"
    patch "/images/:id" => "images#update"
    delete "/images/:id" => "images#destroy"

    get "/users" => "users#index"
    post "/users" => "users#create"
    get "/users/:id" => "users#show"
    # patch "/users/:id" => "users#update"
    # delete "/users/:id" => "users#destroy"

    get "/orders" => "orders#index"
    post "/orders" => "orders#create"
    # get "/orders/:id" => "orders#show"
    # patch "/orders/:id" => "orders#update"
    # delete "/orders/:id" => "orders#destroy"

    get "/carted_products" => "carted_products#index"
    post "/carted_products" => "carted_products#create"
    patch "/carted_products" => "carted_products#update"
    delete "/carted_products/:id" => "carted_products#destroy"
  end
end
