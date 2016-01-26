require 'json'
path = File.join(File.dirname(__FILE__), '../data/products.json')
file = File.read(path)
toys_data = JSON.parse(file)
puts toys_data.class
# Print today's date
require 'date'
current_time = DateTime.now
date_today = current_time.strftime "%d/%m/%Y"
puts "Today's date is: " + date_today 

puts "                     _            _       "
puts "                    | |          | |      "
puts " _ __  _ __ ___   __| |_   _  ___| |_ ___ "
puts "| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|"
puts "| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\"
puts "| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/"
puts "| |                                       "
puts "|_|                                       "
 
  toys_data["items"].each { |toy| 
    puts toy["title"] #prints name of the toy
    puts "**************************************"   #Saperator
    puts "The retail price : " + toy["full-price"].to_s + " USD" #prints retail price of the toy
    puts "Total Purchases  : #{toy["purchases"].length.to_i}" #prints total number of purchases
    
    total_amount = 0    # Calculates and prints the total amount of sales
    toy["purchases"].each { |purchase|
    total_amount += purchase["price"].to_f
    }
    puts "Total Sales      : #{total_amount} USD"

    total_amount = 0                            # Calculate and print the average price the toy sold for  !!!!!!!!!!!!!!!!!!!!wrong               
    toy["purchases"].each { |purchase|
      total_amount += purchase["price"].to_f
    }
    puts "Average Price    : #{total_amount/toy["purchases"].length} USD" 

    puts "Average Discount : #{toy["full-price"].to_f.round(2) - total_amount.round(2)/toy["purchases"].length.round(2)} USD"
    

    puts "                                      " #Empty Line
    }
  


  puts " _                         _     "
  puts "| |                       | |    "
  puts "| |__  _ __ __ _ _ __   __| |___ "
  puts "| '_ \\| '__/ _` | '_ \\ / _` / __|"
  puts "| |_) | | | (_| | | | | (_| \\__ \\"
  puts "|_.__/|_|  \\__,_|_| |_|\\__,_|___/"
  puts

unique_brands = toys_data["items"].map { |item| item["brand"] }.uniq
  unique_brands.each_with_index { |brand, index|
    puts " "
    puts brand #prints the name of the brand
    puts "**************************************"   #Saperator
      brand_toys = toys_data["items"].select { |item| item["brand"] == brand }

      total_stock_brand = 0
      full_actual_price = 0
      brand_purchases = 0
      brand_sales = 0

      brand_toys.each { |toy| total_stock_brand += toy["stock"].to_i } #counts stock for each brand
      brand_toys.each { |item| brand_purchases += item["purchases"].length.to_i }
      brand_toys.each { |item| 
        item["purchases"].each { |el| brand_sales+= el["price"].to_f
        }
      }
      brand_toys.each { |item| full_actual_price += (item["full-price"].to_f) }
      puts "Total Stock         : #{total_stock_brand}"
      puts "Total Revenue       : #{brand_sales.round(2)} USD"
      average_brand_price = (brand_sales / brand_purchases)
      average_brand_disc = (1 - brand_sales / (full_actual_price*2).to_f)
      puts "Average Brand Price : #{average_brand_price.round(2)} USD"
}
  
      



# Print "Sales Report" in ascii art

# Print today's date

# Print "Products" in ascii art

# For each product in the data set:
	# Print the name of the toy
	# Print the retail price of the toy
	# Calculate and print the total number of purchases
	# Calculate and print the total amount of sales
	# Calculate and print the average price the toy sold for
	# Calculate and print the average discount (% or $) based off the average sales price

# Print "Brands" in ascii art

# For each brand in the data set:
	# Print the name of the brand
	# Count and print the number of the brand's toys we stock
	# Calculate and print the average price of the brand's toys
	# Calculate and print the total sales volume of all the brand's toys combined
