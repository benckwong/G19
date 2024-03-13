library(RSQLite)

data <- dbConnect(SQLite(), "mydatabase.db")

# Define the schema for the order table
orders_schema <- "
CREATE TABLE IF NOT EXISTS orders (
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
   FOREIGN KEY ('customer_id') REFERENCES customer ('customer_id'),
   FOREIGN KEY ('product_id') REFERENCES product ('product_id')
);"


#schema for product table
product_schema <- "
CREATE TABLE IF NOT EXISTS 'product'(
  'product_id' VARCHAR(6) PRIMARY KEY,
  'category_id' VARCHAR(6) NOT NULL,
  'supplier_id' VARCHAR(6) NOT NULL,
  'product_name' CHAR,
  'price' FLOAT,
  ‘discount_rate’ FLOAT,
  FOREIGN KEY ('category_id') REFERENCES category('category_id'),
  FOREIGN KEY ('supplier_id') REFERENCES supplier('supplier_id')
);"

#schema for customer table

customer_schema <- "
CREATE TABLE IF NOT EXISTS 'customer'(
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
payment_schema <- "
CREATE TABLE IF NOT EXISTS payment (
   'payment_id' VARCHAR(6) PRIMARY KEY,
   'order_id' VARCHAR(6),
   'payment_date' DATE,
   'payment_method' CHAR,
   FOREIGN KEY ('order_id') REFERENCES order('order_id')
);"

#schema for supplier table
supplier_schema <- "
CREATE TABLE IF NOT EXISTS 'supplier'(
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
settlement_schema <- "
CREATE TABLE IF NOT EXISTS payment (
   settlement_id VARCHAR(6) PRIMARY KEY,
   settlement_date DATE,
   settlement_type BINARY,
   sale_id VARCHAR(6),
   FOREIGN KEY ('sale_id') REFERENCES sale('sale_id')
);"

# Define the schema for sale table
sale_schema <- "
CREATE TABLE IF NOT EXISTS sale (
    sale_id VARCHAR(6) PRIMARY KEY,
    supplier_id VARCHAR(6),
    product_id VARCHAR(6),
    sale_date DATE,
    FOREIGN KEY ('product_id') REFERENCES product('product_id'),
    FOREIGN KEY ('supplier_id') REFERENCES supplier('supplier_id'),
);"

# Define the schema for category table
category_schema <- "
CREATE TABLE IF NOT EXISTS category (
  category_id VARCHAR(6) PRIMARY KEY,
  category_name TEXT,
);"

#schema for promotion table
promotion_schema <- "
CREATE TABLE IF NOT EXISTS 'promotion'(
  'promotion_id' VARCHAR(6) PRIMARY KEY,
  'supplier_id' VARCHAR(6),
  'promotion_name' CHAR,
  'promotion_fees' FLOAT ,
  'promotion_start_date' DATE,
  'promotion_end_date' DATE,
  FOREIGN KEY ('supplier_id') REFERENCES supplier('supplier_id')
);"

# Execute the schema creation queries
dbExecute(data, orders_schema)
dbExecute(data, product_schema)
dbExecute(data, customer_schema)
dbExecute(data, payment_schema)
dbExecute(data, supplier_schema)
dbExecute(data, settlement_schema)
dbExecute(data, sale_schema)
dbExecute(data, category_schema)
dbExecute(data, promotion_schema)

# Close the connection
dbDisconnect(data)
