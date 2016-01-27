require 'json'
require 'artii'
require 'date'

# Get path to products.json, read the file into a string,
# and transform the string into a usable hash 
def setup_files
	path = File.join(File.dirname(__FILE__), '../data/products.json')
	file = File.read(path)
	$toys_data = JSON.parse(file)
	$report_file = File.new("report.txt", "w+")
end

def create_report

	#Method that creates ascii art headers
	def print_ascii_art_header(header_name)
		header_ascii = Artii::Base.new
		puts header_ascii.asciify(header_name)
	end

	#Method prints current date
	def print_date
		current_time = DateTime.now
		date_today = current_time.strftime "%d/%m/%Y"
		puts "Today's date is: " + date_today 
	end

	setup_files

	#Method includes report products
	def report_products
	$toys_data["items"].each { |toy| 
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
	end

	#Method includes report brands
	def report_brands
	unique_brands = $toys_data["items"].map { |item| item["brand"] }.uniq
	  unique_brands.each_with_index { |brand, index|
	    puts " "
	    puts brand #prints the name of the brand
	    puts "**************************************"   #Saperator
	    brand_toys = $toys_data["items"].select { |item| item["brand"] == brand }

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
	end

	# Print "sales seport" in ascii art
	print_ascii_art_header("sales report")

	# Print today's date
	print_date

	# Print "products" in ascii art
	print_ascii_art_header("products")

	#prints products part of the report
	report_products

	# Print "brands" in ascii art
	print_ascii_art_header("brands")
	
	#prints brands part of the report
	report_brands
	
end

create_report
File.open("out.txt", 'w+') {|f| f.write("write your stuff here") }