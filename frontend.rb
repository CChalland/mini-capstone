require "unirest"
require "pp"
@baseurl = "http://localhost:3000/v1/"

def print_menu
  system "clear"
  puts "Welcome to the Hockey Store! Select an option:"
  puts "[1] See all the products"
  puts "     [1.1] Search by porduct's name"
  puts "     [order] Order product(s)"
  puts "     [show] Show ordered product(s)"
  puts "[2] Create a new product"
  puts "[3] Show a particular item"
  puts "[4] Update the particular item"
  puts "[5] Delete the particular item"
  puts 
  puts "[inputuser] Create a new User"
  puts "[login] Login with Username and password"
  puts "[q] Quit"
end

def see_all
  response = Unirest.get("#{@baseurl}products")
  all_products = response.body
  pp all_products
end

def search_name(input)
  search_name = gets.chomp
  response = Unirest.get("#{@baseurl}products", parameters: {search_name: search_name})
  # response = Unirest.get("#{@baseurl}products?name=#{search_name}")
  product = response.body
  pp product
end

def sort_desc
  search_price = "desc"
  response = Unirest.get("#{@baseurl}products", parameters: {search_price: search_price})
  all_products = response.body
  pp all_products
end

def order
  params = {}
  puts "Enter the following information for the product"
  print "Enter the product ID: "
  params[:product_id] = gets.chomp
  print "Enter the product's quantity: "
  params[:quantity] = gets.chomp.to_i
  response = Unirest.post("#{@baseurl}orders/", parameters: params)
  product = response.body
  pp product
end

def show_order
  response = Unirest.get("#{@baseurl}orders")
  order = response.body
  pp order
end

def createImage
  params = {}
  puts "Enter the following urls for the product's images"
  puts "Enter first(1st) url"
  params[:url1] = gets.chomp
  puts "Enter second(2nd) url"
  params[:url2] = gets.chomp
  puts "Enter the third(3rd) url"
  params[:url3] = gets.chomp
  response = Unirest.post("#{@baseurl}images/", parameters: params)
  image = response.body
  pp image
end

def createProduct
  params = {}
  puts "Enter the following infomation for the product"
  puts "Enter the product name:"
  params[:name] = gets.chomp
  puts "Enter the product's price:"
  params[:price] = gets.chomp
  puts "Enter the product's image:"
  params[:image] = createImage
  puts "Enter the product's description:"
  params[:description] = gets.chomp
  response = Unirest.post("#{@baseurl}products/", parameters: params)
  product = response.body
  pp product
end

def show_item
  puts "Enter the product ID#:"
  input_id = gets.chomp
  response = Unirest.get("#{@baseurl}products/#{input_id}")
  product = response.body
  pp product
end

def update_item
  puts "Enter the product ID#:"
  input_id = gets.chomp
  params = {}
  puts "Change the following infomation"
  print "Enter the new product's name: "
  params[:name] = gets.chomp
  print "Enter the new product's price: "
  params[:price] = gets.chomp
  print "Enter the new product's image: "
  params[:image_id] = gets.chomp
  print "Enter the new product's description: "
  params[:description] = gets.chomp
  response = Unirest.patch("#{@baseurl}products/#{input_id}", parameters: params)
  product = response.body
  pp product
end

def delete_item
  puts "Enter the product ID#:"
  input_id = gets.chomp
  response = Unirest.delete("#{@baseurl}products/#{input_id}")
  pp response.body
end

def create_user
  params = {}
  print "Enter the user name: "
  params[:user_name] = gets.chomp
  print "Enter the email: "
  params[:email] = gets.chomp
  print "Enter the password: "
  params[:password] = gets.chomp
  print "Enter the password again: "
  params[:password_confirmation] = gets.chomp
  response = Unirest.post("#{@baseurl}users/", parameters: params)
  pp response.body
end

def login
  params = {}
  print "Enter the Email: "
  params[:email] = gets.chomp
  print "Enter the password: "
  params[:password] = gets.chomp
  response = Unirest.post(
    "#{@baseurl}user_token",
    parameters: {auth: {email: params[:email], password: params[:password]}}
  )
  pp response.body
  # Save the JSON web token from the response
  jwt = response.body["jwt"]
  # Include the jwt in the headers of any future web requests
  Unirest.default_header("Authorization", "Bearer #{jwt}")
end

def logout
  jwt = ""
  Unirest.clear_default_header()
end

def quit
  puts "Goodbye!"
  exit
end

while true
  print_menu
  input_answer = gets.chomp
  if input_answer == "1"
    see_all
  elsif input_answer == "1.1"
    search_name
  elsif input_answer == "1.2"
    sort_desc
  elsif input_answer == "2"
    createProduct 
  elsif input_answer == "3"
    show_item
  elsif input_answer == "4"
    update_item
  elsif input_answer == "5"
    delete_item
  elsif input_answer == "inputuser"
    create_user
  elsif input_answer == "login"
    login
  elsif input_answer == "logout"
    logout
  elsif input_answer == "order"
    order
  elsif input_answer == "show"
    show_order
  elsif input_answer == "q"
    quit
  end
  puts
  puts "Press enter to continue"
  gets.chomp
end




# require "unirest"
# require "pp"
# baseurl = "http://localhost:3000/v1/"

# while true
#   system "clear"
#   puts "Welcome to the Hockey Store! Select an option:"
#   puts "[1] See all the products"
#   puts "     [1.1] Search by porduct's name"
#   puts "     [order] Order product(s)"
#   puts "     [show] Show ordered product(s)"
#   puts "[2] Create a new product"
#   puts "[3] Show a particular item"
#   puts "[4] Update the particular item"
#   puts "[5] Delete the particular item"
#   puts 
#   puts "[inputuser] Create a new User"
#   puts "[login] Login with Username and password"
#   puts "[q] Quit"

#   input_answer = gets.chomp

#   if input_answer == "1"
#     response = Unirest.get("#{baseurl}products")
#     all_products = response.body
#     pp all_products
#   elsif input_answer == "1.1"
#     search_name = gets.chomp
#     response = Unirest.get("#{baseurl}products", parameters: {search_name: search_name})
#     # response = Unirest.get("#{baseurl}products?name=#{search_name}")
#     product = response.body
#     pp product
#   elsif input_answer == "1.2"
#     search_price = "desc"
#     response = Unirest.get("#{baseurl}products", parameters: {search_price: search_price})
#     all_products = response.body
#     pp all_products
#   elsif input_answer == "2"
#     params = {}
#     puts "Enter the following infomation for the product"
#     puts "Enter the product name:"
#     params[:name] = gets.chomp
#     puts "Enter the product's price:"
#     params[:price] = gets.chomp
#     puts "Enter the product's image:"
#     params[:image] = gets.chomp
#     puts "Enter the product's description:"
#     params[:description] = gets.chomp
#     response = Unirest.post("#{baseurl}products/", parameters: params)
#     product = response.body
#     pp product
    
#   elsif input_answer == "3"
#     puts "Enter the product ID#:"
#     input_id = gets.chomp
#     response = Unirest.get("#{baseurl}products/#{input_id}")
#     product = response.body
#     pp product

#   elsif input_answer == "4"
#     puts "Enter the product ID#:"
#     input_id = gets.chomp
#     params = {}
#     puts "Change the following infomation"
#     print "Enter the new product's name: "
#     params[:name] = gets.chomp
#     print "Enter the new product's price: "
#     params[:price] = gets.chomp
#     print "Enter the new product's image: "
#     params[:image] = gets.chomp
#     print "Enter the new product's description: "
#     params[:description] = gets.chomp
#     response = Unirest.patch("#{baseurl}products/#{input_id}", parameters: params)
#     product = response.body
#     pp product

#   elsif input_answer == "5"
#     puts "Enter the product ID#:"
#     input_id = gets.chomp
#     response = Unirest.delete("#{baseurl}products/#{input_id}")
#     pp response.body

#   elsif input_answer == "inputuser"
#     params = {}
#     print "Enter the user name: "
#     params[:user_name] = gets.chomp
#     print "Enter the email: "
#     params[:email] = gets.chomp
#     print "Enter the password: "
#     params[:password] = gets.chomp
#     print "Enter the password again: "
#     params[:password_confirmation] = gets.chomp
#     response = Unirest.post("#{baseurl}users/", parameters: params)
#     pp response.body

#   elsif input_answer == "login"
#     params = {}
#     print "Enter the Email: "
#     params[:email] = gets.chomp
#     print "Enter the password: "
#     params[:password] = gets.chomp
#     response = Unirest.post(
#       "#{baseurl}user_token",
#       parameters: {auth: {email: params[:email], password: params[:password]}}
#     )
#     pp response.body
#     # Save the JSON web token from the response
#     jwt = response.body["jwt"]
#     # Include the jwt in the headers of any future web requests
#     Unirest.default_header("Authorization", "Bearer #{jwt}")

#   elsif input_answer == "logout"
#     jwt = ""
#     Unirest.clear_default_header()

#   elsif input_answer == "order"
#     params = {}
#     puts "Enter the following information for the product"
#     print "Enter the product ID: "
#     params[:product_id] = gets.chomp
#     print "Enter the product's quantity: "
#     params[:quantity] = gets.chomp.to_i
#     response = Unirest.post("#{baseurl}orders/", parameters: params)
#     product = response.body
#     pp product

#   elsif input_answer == "show"
#     response = Unirest.get("#{baseurl}orders")
#     order = response.body
#     pp order

#   elsif input_answer == "q"
#     puts "Goodbye!"
#     break
#   end

#   puts
#   puts "Press enter to continue"
#   temp = gets.chomp
# end











# response = Unirest.get("http://localhost:3000/v1/all_products_info")
# all_products = response.body

# def print_info(input)
#   system "clear"
#   puts "Welcome to Cole's Hockey Store!!"

#   i = 1
#   input.each do |product|
#     puts "#{i}. #{product["name"]}"
#     i += 1
#   end
#   puts "Enter the number product to view product's full infomation."
# end

# while true
#   print_info(all_products)
#   temp = gets.chomp
#   answer = temp.to_i - 1
#   puts "#{temp}. #{all_products[answer]["name"]}"
#   puts "    Image url: #{all_products[answer]["image"]}"
#   puts "    Price: #{all_products[answer]["price"]}"
#   puts "    Description: #{all_products[answer]["description"]}"
#   puts "Enter 'Q' to quit the program or any other key to conutine."
#   input_answer = gets.chomp
#   if input_answer == 'Q'
#     break
#   end
# end
