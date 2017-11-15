Rails.application.routes.draw do
  namespace :v1 do
    get "/all_products_info" => "products#all_products_info_method"
    get "/skates" => "products#skates_method"
    get "/shins" => "products#shins_method"
    get "/pants" => "product#pants_method"
    get "/sholders" => "products#sholders_method"
    get "/elbows" => "products#elbows_method"
    get "/gloves" => "products#gloves_method"
  end
end
