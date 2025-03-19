-- TASK 1
create database Techshop;
use Techshop;
create table customers(CustomerID int primary key, Firstname varchar(20), Lastname varchar(20), Email varchar(20), Phone int, Address Text);
--DESCRIBE cutomers;
--create table products(ProductsID int primary key, Productname varchar(20), Description varchar(20), Price int);
--create table orders(OrderID int primary key, Foreign key (CustomerID) references customers(CustomerID),foreign key (ProductID) references products(ProductID), Quantity int);
--drop table products;
CREATE TABLE products (
    ProductID INT PRIMARY KEY, 
    Productname VARCHAR(20),
    Description VARCHAR(20),
    Price INT
);

CREATE TABLE orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (CustomerID) REFERENCES customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES products(ProductID)  
);
select * from orders;

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES products(ProductID)
);

CREATE TABLE inventory(
    InventoryID int Primary key,
	ProductID int,
	QuantityInStock int,
	LastStockUpdate int
	FOREIGN KEY (ProductID) REFERENCES products(ProductID)
);
 ALTER TABLE customers
ALTER COLUMN Phone VARCHAR(20);

ALTER TABLE customers
ALTER COLUMN Email VARCHAR(100);

INSERT INTO customers (CustomerID, Firstname, Lastname, Email, Phone, Address)
VALUES 
(1, 'Kumar', 'Rajan', 'kumarrajan@email.com', 9445678901, '123 Anna Nagar, Chennai, Tamil Nadu'),
(2, 'Priya', 'Vijay', 'priyavijay@email.com', 9445789012, '456 T. Nagar, Chennai, Tamil Nadu'),
(3, 'Arun', 'Murugan', 'arunmurugan@email.com', 9445890123, '789 Mylapore, Chennai, Tamil Nadu'),
(4, 'Sita', 'Krishnan', 'sitakrishnan@email.com', 9445901234, '101 Besant Nagar, Chennai, Tamil Nadu'),
(5, 'Ravi', 'Subramanian', 'ravisubramanian@email.com', 9446012345, '202 Adyar, Chennai, Tamil Nadu'),
(6, 'Anjali', 'Iyer', 'anjaliiyer@email.com', 9446123456, '303 Kodambakkam, Chennai, Tamil Nadu'),
(7, 'Vikram', 'Sundar', 'vikramsundar@email.com', 9446234567, '404 Velachery, Chennai, Tamil Nadu'),
(8, 'Divya', 'Raghavan', 'divyaraghavan@email.com', 9446345678, '505 Guindy, Chennai, Tamil Nadu'),
(9, 'Manoj', 'Balaji', 'manojbalaji@email.com', 9446456789, '606 Perungudi, Chennai, Tamil Nadu'),
(10, 'Lakshmi', 'Chandrasekar', 'lakshmichandrasekar@email.com', 9446567890, '707 OMR, Chennai, Tamil Nadu');

ALTER TABLE products
ALTER COLUMN Description VARCHAR(255);

INSERT INTO products (ProductID, Productname, Description, Price)
VALUES 
(1, 'Smartphone', 'Mobile phone with latest features', 15000),  
(2, 'LED TV', 'High-definition LED television', 35000),  
(3, 'Laptop', 'Powerful laptop for work and entertainment', 50000),  
(4, 'Toy', 'Fun toy for kids', 500),  
(5, 'Pen', 'High-quality writing pen', 200),  
(6, 'Sofa', 'Comfortable sofa for living room', 10000),  
(7, 'Bed', 'Double bed with modern design', 8000),  
(8, 'Mouse', 'Wireless computer mouse', 1000),  
(9, 'Flowers', 'Fresh flowers for decoration', 300),  
(10, 'Jewelry', 'Elegant gold jewelry', 25000);

INSERT INTO orders (OrderID, CustomerID, ProductID, Quantity)
VALUES 
(1, 1, 1, 2),
(2, 2, 3, 1),
(3, 3, 2, 1),
(4, 4, 4, 5),
(5, 5, 5, 3),
(6, 6, 6, 2),
(7, 7, 7, 1),
(8, 8, 8, 4),
(9, 9, 9, 10),
(10, 10, 10, 1);

INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity)
VALUES
(1, 1, 1, 2),  
(2, 1, 2, 3),  
(3, 2, 3, 5),  
(4, 2, 4, 1),  
(5, 3, 5, 10), 
(6, 3, 6, 2),  
(7, 4, 7, 7),  
(8, 4, 8, 4),  
(9, 5, 9, 6),  
(10, 5, 10, 3); 

INSERT INTO inventory (InventoryID, ProductID, QuantityInStock, LastStockUpdate)
VALUES 
(1, 1, 100, 20250319),
(2, 2, 50, 20250318),
(3, 3, 30, 20250317),
(4, 4, 200, 20250316),
(5, 5, 500, 20250315),
(6, 6, 60, 20250314),
(7, 7, 20, 20250313),
(8, 8, 150, 20250312),
(9, 9, 1000, 20250311),
(10, 10, 75, 20250310);

-- TASK 2

SELECT Firstname, Lastname, Email FROM customers;

ALTER TABLE orders
DROP COLUMN Quantity;

SELECT 
    fk.name AS FK_constraint_name
FROM 
    sys.foreign_keys fk
JOIN 
    sys.tables t ON fk.parent_object_id = t.object_id
WHERE 
    t.name = 'orders';

ALTER TABLE orders
DROP CONSTRAINT FK__orders__ProductI__5535A963;

ALTER TABLE orders
DROP COLUMN ProductID;

ALTER TABLE orders
ADD OrderDate DATE,
TotalAmount DECIMAL(10, 2);

UPDATE orders
SET OrderDate = '2025-03-20', 
    TotalAmount = 100.50       
WHERE OrderID BETWEEN 1 AND 10;  

select * from orders;

SELECT 
    OrderID,
    OrderDate,
    Firstname + ' ' + Lastname AS CustomerName
FROM 
    orders
JOIN 
    customers ON orders.CustomerID = customers.CustomerID;

--UPDATE Products
--SET Price = Price * 1.10
--WHERE Productname LIKE '%electronic%'; 

INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES (101, 1, '2025-03-20', 250.75);

UPDATE Customers
SET 
Email = 'newemail@example.com',      
Address = 'New Address, City, Country' 
WHERE CustomerID = 1;  

UPDATE o
SET o.TotalAmount = (
    SELECT SUM(od.Quantity * p.Price)
    FROM OrderDetails od
    JOIN Products p ON od.ProductID = p.ProductID
    WHERE od.OrderID = o.OrderID
    GROUP BY od.OrderID
)
FROM Orders o;

select OrderID from orders;




