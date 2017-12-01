require "unirest"
require "pp"

class User
  attr_reader :admin_user, :quit_temp

  def initialize
    @jwt = ""
    @menu_options = [
      {id: 10, value: "1", prompt: "Show all products", method: -> do show_all_products end},
      {id: 11, value: "1.1", prompt: "\tShow all products that match search terms", method: -> do show_all_products_search end},
      {id: 12, value: "1.2", prompt: "\tShow all products sorted by price", method: -> do show_all_products_sorted_by_price end},
      {id: 20, value: "2", prompt: "Create Settings", method: nil},
      {id: 30, value: "3", prompt: "Show one product", method: -> do show_one_product end},
      {id: 40, value: "4", prompt: "Update Settings", method: nil},
      {id: 50, value: "5", prompt: "Delete Settings", method: nil},
      {id: 60, value: "6", prompt: "Order a product", method: -> do order_product end},
      {id: 70, value: "7", prompt: "View all orders", method: -> do show_all_orders end},
      {id: 80, value: "signup", prompt: "Sign up (create a user)", method: -> do signup end},
      {id: 90, value: "login", prompt: "Log in (create a jwt)", method: -> do login end},
      {id: 100, value: "logout", prompt: "Log out (destroy the jwt)", method: -> do logout end},
      {id: 110, value: "q", prompt: "Quit", method: -> do quit end}
    ]
    @admin_user = false
    @quit_temp = false
    @user_email = ""
  end

  def find_menu_option(input_value)
    @menu_options.each do |menu_option|
      if menu_option[:value] == input_value
        return menu_option
      end
    end
    return nil
  end

  def show_menu
    system "clear"
    puts "Choose an option:"
    options = @menu_options.sort_by(&:values)
    options.each do |menu_option|
      puts "[#{menu_option[:value]}] #{menu_option[:prompt]}"
    end
  end

  def show_all_products
    response = Unirest.get("http://localhost:3000/v1/products")
    products = response.body
    pp products
  end

  def show_all_products_search
    print "Enter search terms: "
    input_search_terms = gets.chomp
    response = Unirest.get("http://localhost:3000/v1/products?search_name=#{input_search_terms}")
    products = response.body
    pp products
  end

  def show_all_products_sorted_by_price
    response = Unirest.get("http://localhost:3000/v1/products?search_price=true")
    products = response.body
    pp products
  end

  def show_one_product
    print "Enter a product id: "
    product_id = gets.chomp
    response = Unirest.get("http://localhost:3000/v1/products/#{product_id}")
    product = response.body
    pp product
  end

  def order_product
    params = {}
    print "Product id: "
    params[:input_product_id] = gets.chomp
    print "Quantity: "
    params[:input_quantity] = gets.chomp
    response = Unirest.post("http://localhost:3000/v1/orders", parameters: params)
    order = response.body
    if order["errors"]
      puts "No good!"
      p order["errors"]
    else
      puts "All good!"
      pp order
    end
  end

  def show_all_orders
    response = Unirest.get("http://localhost:3000/v1/orders")
    orders = response.body
    pp orders
  end

  def signup
    print "Enter username: "
    input_name = gets.chomp
    print "Enter email: "
    input_email = gets.chomp
    print "Enter password: "
    input_password = gets.chomp
    print "Confirm password: "
    input_password_confirmation = gets.chomp
    response = Unirest.post(
      "http://localhost:3000/v1/users",
      parameters: {
        user_name: input_name,
        email: input_email,
        password: input_password,
        password_confirmation: input_password_confirmation
      }
    )
    pp response.body
  end

  def login
    print "Enter email: "
    @user_email = gets.chomp
    print "Enter password: "
    input_password = gets.chomp
    response = Unirest.post(
      "http://localhost:3000/user_token",
      parameters: {
        auth: {
          email: @user_email,
          password: input_password
        }
      }
    )
    @jwt = response.body["jwt"]
    Unirest.default_header("Authorization", "Bearer #{@jwt}")
    pp response.body
  end

  def logout
    @jwt = ""
    @admin_user = false
    Unirest.clear_default_headers()
    puts "Logged out successfully!"
  end

  def quit
    puts "Goodbye!"
    @quit = true   
    exit
  end

  def run
    while true
      show_menu
      input_option = gets.chomp
      menu_option = find_menu_option(input_option)
      if menu_option
        menu_option[:method].call
        if input_option == "login"
          response = Unirest.get("http://localhost:3000/v1/users?search_user_email=#{@user_email}")
          user = response.body
          if user[0]["admin"]
            @admin_user = true
            break
          end
        end
      else
        puts "Unknown option."        
      end
      puts "Press enter to continue"
      gets.chomp
    end    
  end
end

class Admin < User

  def initialize
    super
    @menu_options << {id: 13, value: "1.3", prompt: "**Show one User", method: -> do show_one_user end}
    @menu_options << {id: 14, value: "1.4", prompt: "**Show all Users", method: -> do show_all_users end}
    @menu_options << {id: 15, value: "1.5", prompt: "**Show all Users that match search terms", method: -> do show_all_users_search end}
    @menu_options << {id: 16, value: "1.6", prompt: "**Show all Users sorted by their join date", method: -> do show_all_users_sorted_by_created end}
    @menu_options << {id: 21, value: "2.1", prompt: "**Create a supplier", method: -> do create_supplier end}
    @menu_options << {id: 22, value: "2.2", prompt: "**Create a product", method: -> do create_product end}
    @menu_options << {id: 23, value: "2.3", prompt: "**Create a Image for product", method: -> do create_image end}
    @menu_options << {id: 41, value: "4.1", prompt: "**Update a supplier", method: -> do update_supplier end}
    @menu_options << {id: 42, value: "4.2", prompt: "**Update a product", method: -> do update_product end}
    @menu_options << {id: 43, value: "4.3", prompt: "**Update a image", method: -> do update_image end}
    @menu_options << {id: 44, value: "4.4", prompt: "**Update a user", method: -> do update_user end}
    @menu_options << {id: 51, value: "5.1", prompt: "**Delete a supplier", method: -> do delete_supplier end}
    @menu_options << {id: 52, value: "5.2", prompt: "**Delete a product", method: -> do delete_product end}
    @menu_options << {id: 53, value: "5.3", prompt: "**Delete a image", method: -> do delete_image end}
    @menu_options << {id: 54, value: "5.4", prompt: "**Delete a user", method: -> do delete_user end}
  end

  def create_supplier
    params = {}
    print "New supplier name: "
    params[:name] = gets.chomp
    print "New supplier email: "
    params[:email] = gets.chomp
    print "New supplier phone number: "
    params[:phone_number] = gets.chomp
    response = Unirest.post("http://localhost:3000/v1/suppliers", parameters: params)
    supplier = response.body
    if supplier["errors"]
      puts "No good!"
      p supplier["errors"]
    else
      puts "All good!"
      pp supplier
    end
  end
  
  def create_product
    params = {}
    print "New product name: "
    params[:name] = gets.chomp
    print "New product price: "
    params[:price] = gets.chomp
    print "New product description: "
    params[:description] = gets.chomp
    print "New product supplier_id: "
    params[:supplier_id] = gets.chomp
    response = Unirest.post("http://localhost:3000/v1/products", parameters: params)
    product = response.body
    if product["errors"]
      puts "No good!"
      p product["errors"]
    else
      puts "All good!"
      pp product
    end
  end

  def create_image
    params = {}
    puts "Enter the following url for the product's images"
    puts "Enter the url"
    params[:url] = gets.chomp
    print "Enter image's product_id:"
    params[:product_id] = gets.chomp
    response = Unirest.post("http://localhost:3000/v1/images", parameters: params)
    image = response.body
    if image["errors"]
      puts "No good!"
      p image["errors"]
    else
      puts "All good!"
      pp image
    end
  end

  def show_all_users
    response = Unirest.get("http://localhost:3000/v1/users")
    products = response.body
    pp products
  end

  def show_all_users_search
    print "Enter search terms: "
    input_search_terms = gets.chomp
    response = Unirest.get("http://localhost:3000/v1/users?search_user_name=#{input_search_terms}")
    products = response.body
    pp products
  end

  def show_all_users_sorted_by_created
    response = Unirest.get("http://localhost:3000/v1/users?search_user_created=true")
    products = response.body
    pp products
  end

  def show_one_user
    print "Enter a user id: "
    user_id = gets.chomp.to_i
    response = Unirest.get("http://localhost:3000/v1/users/#{user_id}")
    product = response.body
    pp product
  end

  def update_supplier
    print "Enter a supplier id: "
    supplier_id = gets.chomp
    response = Unirest.get("http://localhost:3000/v1/suppliers/#{supplier_id}")
    supplier = response.body
    params = {}
    print "New supplier name (#{supplier[:name]}): "
    params[:name] = gets.chomp
    print "New supplier email: (#{supplier[:email]})"
    params[:email] = gets.chomp
    print "New supplier phone number (#{supplier[:phone_number]}): "
    params[:phone_number] = gets.chomp
    params.delete_if { |_key, value| value.empty? }
    response = Unirest.patch("http://localhost:3000/v1/suppliers/#{supplier_id}", parameters: params)
    product = response.body
    pp response.body
  end

  def update_product
    print "Enter a product id: "
    product_id = gets.chomp
    response = Unirest.get("http://localhost:3000/v1/products/#{product_id}")
    product = response.body
    params = {}
    print "Updated product name (#{product[:name]}): "
    params[:name] = gets.chomp
    print "Updated product price (#{product[:price]}): "
    params[:price] = gets.chomp
    print "Updated product description (#{product[:description]}): "
    params[:description] = gets.chomp 
    print "Updated product supplier_id (#{product[:supplier_id]}): "
    params[:supplier_id] = gets.chomp
    print "Updated product availability(#{product[:availability]}): "
    gets.chomp == "false" ? params[:availability] = false : true
    params.delete_if { |_key, value| value.empty? }
    response = Unirest.patch("http://localhost:3000/v1/products/#{product_id}", parameters: params)
    product = response.body
    pp response.body
  end

  def update_image
    print "Enter the image id: "
    image_id = gets.chomp
    response = Unirest.get("http://localhost:3000/v1/images/#{image_id}")
    product = response.body
    params = {}
    print "Updated product image (#{image[:url]}): "
    params[:url] = gets.chomp
    print "Updated image's product ID (#{image[:product_id]}): "
    params[:product_id] = gets.chomp
    print "Updated product description (#{product[:description]}): "
    params.delete_if { |_key, value| value.empty? }
    response = Unirest.patch("http://localhost:3000/v1/images/#{image_id}", parameters: params)
    product = response.body
    pp response.body
  end

  def update_user
    print "Enter the user id: "
    user_id = gets.chomp
    response = Unirest.get("http://localhost:3000/v1/users/#{user_id}")
    user = response.body
    params = {}
    print "Update username (#{user[:user_name]}): "
    params[:user_name] = gets.chomp
    print "Update user email (#{user[:email]}): "
    params[:email] = gets,chomp
    print "Change passowrd: "
    params[:password] = gets.chomp
    print "Change password confirmation: "
    params[:password_confirmation] = gets.chomp
    params.delete_if { |_key, value| value.empty? }
    response = Unirest.patch("http://localhost:3000/v1/users/#{user_id}", parameters: params)
    user = response.body
    pp response.body
  end

  def delete_supplier
    print "Enter a supplier id: "
    supplier_id = gets.chomp
    response = Unirest.delete("http://localhost:3000/v1/suppliers/#{supplier_id}")
    pp response.body
  end

  def delete_product
    print "Enter a product id: "
    product_id = gets.chomp
    response = Unirest.delete("http://localhost:3000/v1/products/#{product_id}")
    pp response.body
  end

  def delete_image
    print "Enter a image id: "
    image_id = gets.chomp
    response = Unirest.delete("http://localhost:3000/v1/images/#{image_id}")
    pp response.body
  end

  def delete_user
    print "Enter a user id: "
    user_id = gets.chomp
    response = Unirest.delete("http://localhost:3000/v1/users/#{user_id}")
    pp response.body
  end
end

user = User.new
admin = Admin.new
user.run()
unless user.quit_temp
  if user.admin_user
    admin.run()
  else
    user.run()
  end
end
