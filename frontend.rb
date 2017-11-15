require "unirest"

response = Unirest.get("http://localhost:3000/all_products_info")
all_products = response.body


  system "clear"
  puts "Welcome to Cole's Hockey Store!!"

  i = 1
  all_products.each do |product|
    puts "#{i}. #{product["name"]}"
    i += 1
  end
  puts "Enter the number product to view product's full infomation."

while true
  temp = gets.chomp
  if temp == 'Q'
    break
  end
  system "clear"
  answer = temp.to_i - 1
  puts "#{temp}. #{all_products[answer]["name"]}"
  puts "    Image url: #{all_products[answer]["image"]}"
  puts "    Price: #{all_products[answer]["price"]}"
  puts "    Description: #{all_products[answer]["description"]}"
  puts "Enter 'Q' to quit the program or any other key to conutine."
end