library(RSQLite)

data <- dbConnect(SQLite(), "mydatabase.db")

# Define the schema for the order table
Order_schema <- "
CREATE TABLE IF NOT EXISTS Orders(
   order_id VARCHAR(6) PRIMARY KEY,
   product_id VARCHAR(6) NOT NULL,
   customer_id VARCHAR(6) NOT NULL,
   order_date DATE,
   order_quantity INTEGER,
   order_status CHECK (Order_status IN ('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled')),
   order_approval_date DATE NOT NULL,
   order_delivery_date DATE NOT NULL,
   rating_date DATE NOT NULL,
   rating_score FLOAT,
   rating_comment CHAR,
   FOREIGN KEY ('customer_id') REFERENCES Customer ('customer_id'),
   FOREIGN KEY ('product_id') REFERENCES Product ('product_id')
);"


#schema for product table
Product_schema <- "
CREATE TABLE IF NOT EXISTS 'Product'(
  'product_id' VARCHAR(6) PRIMARY KEY,
  'category_id' VARCHAR(6) NOT NULL,
  'supplier_id' VARCHAR(6) NOT NULL,
  'product_name' CHAR,
  'price' FLOAT,
  ‘discount_rate’ FLOAT,
  FOREIGN KEY ('category_id') REFERENCES Category('category_id'),
  FOREIGN KEY ('supplier_id') REFERENCES Supplier('supplier_id')
);"

#schema for customer table
Customer_schema <- "
CREATE TABLE IF NOT EXISTS 'Customer'(
  'customer_id' VARCHAR(6) PRIMARY KEY,
  'customer_first_name' CHAR(50),
  'customer_last_name' CHAR(50) ,
  'customer_email' VARCHAR(200) ,
  'registration_date' DATE,
  'customer_phone' INT(11),
  'customer_address' VARCHAR ,
  'customer_city' CHAR,
  'customer_state' CHAR,
  'customer_postcode' VARCHAR
);"


# Define the schema for the payment table
Payment_schema <- "
CREATE TABLE IF NOT EXISTS Payment (
   'payment_id' VARCHAR(6) PRIMARY KEY,
   'order_id' VARCHAR(6),
   'payment_date' DATE,
   'payment_method' CHAR,
   FOREIGN KEY ('order_id') REFERENCES Orders('order_id')
);"

#schema for supplier table
Supplier_schema <- "
CREATE TABLE IF NOT EXISTS 'Supplier'(
'supplier_id' VARCHAR(6) PRIMARY KEY,
'seller_name'  TEXT,
'seller_email' VARCHAR(200),
'seller_address' VARCHAR(200),
'seller_city' CHAR(50) ,
'seller_state' CHAR(50) ,
'seller_postcode' VARCHAR,
'seller_phone' INT(11) ,
'registration_date' DATE ,
'platform_rate' FLOAT,
'tax_rate' FLOAT
);"


# Define the schema for settlement table
Settlement_schema <- "
CREATE TABLE IF NOT EXISTS Settlement (
   settlement_id VARCHAR(6) PRIMARY KEY,
   settlement_date DATE,
   settlement_type BINARY,
   sale_id VARCHAR(6),
   FOREIGN KEY ('sale_id') REFERENCES Sales('sale_id')
);"

# Define the schema for sales table
Sales_schema <- "
CREATE TABLE IF NOT EXISTS Sales (
    sale_id VARCHAR(6) PRIMARY KEY,
    supplier_id VARCHAR(6),
    product_id VARCHAR(6),
    sale_date DATE,
    FOREIGN KEY ('product_id') REFERENCES Product('product_id'),
    FOREIGN KEY ('supplier_id') REFERENCES Supplier('supplier_id')
);"

# Define the schema for category table
Category_schema <- "
CREATE TABLE IF NOT EXISTS Category (
  category_id VARCHAR(6) PRIMARY KEY,
  product_id VARCHAR(6),
  category_name TEXT,
  category_level INTEGER
);"


#schema for promotion table
Promotion_schema <- "
CREATE TABLE IF NOT EXISTS 'Promotion'(
  'promotion_id' VARCHAR(6) PRIMARY KEY,
  'supplier_id' VARCHAR(6),
  'promotion_name' CHAR,
  'promotion_fees' FLOAT ,
  'promotion_start_date' DATE,
  'promotion_end_date' DATE,
  FOREIGN KEY ('supplier_id') REFERENCES Supplier('supplier_id')
);"

# Execute the schema creation queries
dbExecute(data, Orders_schema)
dbExecute(data, Product_schema)
dbExecute(data, Customer_schema)
dbExecute(data, Payment_schema)
dbExecute(data, Supplier_schema)
dbExecute(data, Settlement_schema)
dbExecute(data, Sales_schema)
dbExecute(data, Category_schema)
dbExecute(data, Promotion_schema)

# Close the connection
dbDisconnect(data)
