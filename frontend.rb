require "unirest"
require "pp"

while true
  system "clear"
  puts "Welcome to the Hockey Store! Select an option:"
  puts "[1] See all the products"
  puts "     [order] Order product(s)"
  puts "     [show] Show ordered product(s)"
  puts "     [1.1] Search by porduct's name"
  puts "[2] Create a new product"
  puts "[3] Show a particular item"
  puts "[4] Update the particular item"
  puts "[5] Delete the particular item"
  puts 
  puts "[inputuser] Create a new User"
  puts "[login] Login with Username and password"
  puts "[q] Quit"

  input_answer = gets.chomp

  if input_answer == "1"
    response = Unirest.get("http://localhost:3000/v1/products")
    all_products = response.body
    pp all_products
  elsif input_answer == "1.1"
    search_name = gets.chomp
    response = Unirest.get("http://localhost:3000/v1/products", parameters: {search_name: search_name})
    # response = Unirest.get("http://localhost:3000/v1/products?name=#{search_name}")
    product = response.body
    pp product
  elsif input_answer == "1.2"
    search_price = "desc"
    response = Unirest.get("http://localhost:3000/v1/products", parameters: {search_price: search_price})
    all_products = response.body
    pp all_products
  elsif input_answer == "2"
    params = {}
    puts "Enter the following infomation for the product"
    puts "Enter the product name:"
    params[:name] = gets.chomp
    puts "Enter the product's price:"
    params[:price] = gets.chomp
    puts "Enter the product's image:"
    params[:image] = gets.chomp
    puts "Enter the product's description:"
    params[:description] = gets.chomp
    response = Unirest.post("http://localhost:3000/v1/products/", parameters: params)
    product = response.body
    pp product
    
  elsif input_answer == "3"
    puts "Enter the product ID#:"
    input_id = gets.chomp
    response = Unirest.get("http://localhost:3000/v1/products/#{input_id}")
    product = response.body
    pp product

  elsif input_answer == "4"
    puts "Enter the product ID#:"
    input_id = gets.chomp
    params = {}
    puts "Change the following infomation"
    print "Enter the new product's name: "
    params[:name] = gets.chomp
    print "Enter the new product's price: "
    params[:price] = gets.chomp
    print "Enter the new product's image: "
    params[:image] = gets.chomp
    print "Enter the new product's description: "
    params[:description] = gets.chomp
    response = Unirest.patch("http://localhost:3000/v1/products/#{input_id}", parameters: params)
    product = response.body
    pp product

  elsif input_answer == "5"
    puts "Enter the product ID#:"
    input_id = gets.chomp
    response = Unirest.delete("http://localhost:3000/v1/products/#{input_id}")
    pp response.body

  elsif input_answer == "inputuser"
    params = {}
    print "Enter the user name: "
    params[:user_name] = gets.chomp
    print "Enter the email: "
    params[:email] = gets.chomp
    print "Enter the password: "
    params[:password] = gets.chomp
    print "Enter the password again: "
    params[:password_confirmation] = gets.chomp
    response = Unirest.post("http://localhost:3000/v1/users/", parameters: params)
    pp response.body

  elsif input_answer == "login"
    params = {}
    print "Enter the Email: "
    params[:email] = gets.chomp
    print "Enter the password: "
    params[:password] = gets.chomp
    response = Unirest.post(
      "http://localhost:3000/v1/user_token",
      parameters: {auth: {email: params[:email], password: params[:password]}}
    )
    pp response.body
    # Save the JSON web token from the response
    jwt = response.body["jwt"]
    # Include the jwt in the headers of any future web requests
    Unirest.default_header("Authorization", "Bearer #{jwt}")

  elsif input_answer == "logout"
    jwt = ""
    Unirest.clear_default_header()

  elsif input_answer == "order"
    params = {}
    puts "Enter the following infomation for the product"
    print "Enter the product ID: "
    params[:product_id] = gets.chomp
    print "Enter the product's quantity: "
    params[:quantity] = gets.chomp.to_i
    response = Unirest.post("http://localhost:3000/v1/orders/", parameters: params)
    product = response.body
    pp product

  elsif input_answer == "show"
    response = Unirest.get("http://localhost:3000/v1/orders")
    order = response.body
    pp order

  elsif input_answer == "q"
    puts "Goodbye!"
    break
  end

  puts
  puts "Press enter to continue"
  temp = gets.chomp
end
















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
