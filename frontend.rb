require "unirest"
require "tty-table"

table = TTY:Table.new do |t|
  t << 

response = Unirest.get("http://localhost:3000/all_products_info")
all_products = response.body

def print_info(input)
  system "clear"
  puts "Welcome to Cole's Hockey Store!!"

  i = 1
  input.each do |product|
    puts "#{i}. #{product["name"]}"
    i += 1
  end
  puts "Enter the number product to view product's full infomation."
end

while true
  print_info(all_products)
  temp = gets.chomp
  answer = temp.to_i - 1
  puts "#{temp}. #{all_products[answer]["name"]}"
  puts "    Image url: #{all_products[answer]["image"]}"
  puts "    Price: #{all_products[answer]["price"]}"
  puts "    Description: #{all_products[answer]["description"]}"
  puts "Enter 'Q' to quit the program or any other key to conutine."
  input_answer = gets.chomp
  if input_answer == 'Q'
    break
  end
end