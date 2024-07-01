#Governorates Table:

CREATE TABLE Governorates (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL
);
#Stores Table:

CREATE TABLE Stores (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  address VARCHAR(255) NOT NULL,
  governorate_id INT NOT NULL,
  FOREIGN KEY (governorate_id) REFERENCES Governorates(id)
);
#Suppliers Table:

CREATE TABLE Suppliers (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  phone VARCHAR(20),
  email VARCHAR(255),
  brief_data TEXT
);
#Products Table:

CREATE TABLE Products (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  code VARCHAR(50) UNIQUE NOT NULL,  -- Make sure the product code is unique
  description TEXT,
  price DECIMAL(10,2),
  supplier_id INT NOT NULL,
  FOREIGN KEY (supplier_id) REFERENCES Suppliers(id)
);
#Store_Products Table (Many-to-Many Relationship):

CREATE TABLE Store_Products (
  store_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT,
  PRIMARY KEY (store_id, product_id),  -- Composite primary key for M:M relationship
  FOREIGN KEY (store_id) REFERENCES Stores(id),
  FOREIGN KEY (product_id) REFERENCES Products(id)
);

#-------------------------------------------------------

#1. Order details - Products starting with S18 and price over 100 (unique order numbers):
SELECT DISTINCT order_id
FROM orderdetails
WHERE product_code LIKE 'S18%' AND price > 100;

#2. Payments made on day 5 or 6:
SELECT *
FROM payments
WHERE DAYOFMONTH(paymentDate) IN (5, 6);

#3. Fifth-highest credit limit for customers in USA with phone number containing 5555:
SELECT creditLimit
FROM (
  SELECT creditLimit
  FROM customers
  WHERE country = 'USA' AND phone LIKE '%5555%'
) AS filtered_customers
ORDER BY creditLimit DESC
LIMIT 1 OFFSET 4;
 
