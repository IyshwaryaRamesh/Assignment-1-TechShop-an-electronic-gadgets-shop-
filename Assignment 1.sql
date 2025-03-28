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
--retrieve the names and emails of all customers.  
SELECT Firstname, Lastname, Email FROM customers;

ALTER TABLE orders
DROP COLUMN Quantity;

ALTER TABLE orders
DROP CONSTRAINT FK__orders__ProductI__5535A963;

ALTER TABLE orders
DROP COLUMN ProductID;

ALTER TABLE orders
ADD OrderDate DATE,
TotalAmount DECIMAL(10, 2);

--Write an SQL query to list all orders with their order dates and corresponding customer names.
UPDATE orders
SET OrderDate = '2025-03-20', 
    TotalAmount = 100.50       
WHERE OrderID BETWEEN 1 AND 10;  

select * from orders;

SELECT o.OrderID, o.OrderDate, c.FirstName, c.LastName
FROM Orders o ,Customers c
WHERE o.CustomerID = c.CustomerID;
GO

--Insert a new customer record into the Customers table
INSERT INTO Customers (FirstName, LastName, Email, Phone, Address)
VALUES ('iys', 'san', 'iysh@gmail.com', '1128082943', '3a chennai');
SELECT * FROM Customers;
GO 

--Update the prices of all electronic gadgets in the Products table by increasing them by 10%.
INSERT INTO Products (ProductName, Description, Price)--As there no product name gadget i have inserted a new data
VALUES 
('Gadget', 'It is modern TV with all the AI features', 1699.99);
UPDATE Products
SET Price = Price * 1.10
WHERE ProductName LIKE '%Gadget%'; 
SELECT * FROM Products;
GO

--Delete a specific order and its associated order details from the Orders and OrderDetails tables.
DECLARE @OrderID INT;
SET @OrderID = 1;  
DELETE FROM OrderDetails WHERE OrderID = @OrderID;
DELETE FROM Orders WHERE OrderID = @OrderID;
GO

--Insert a new order into the Orders table.
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES (101, 1, '2025-03-20', 250.75);
SELECT * FROM Orders;
GO

--Update the contact information ( email and address) of a specific customer in the Customers table.
UPDATE Customers
SET 
Email = 'newemail@example.com',      
Address = 'New Address, City, Country' 
WHERE CustomerID = 1;  

--update the total cost of each order in the Orders table based on the prices and quantities in the OrderDetails table.
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

--Delete all orders and their associated order details for a specific customer from the Orders and OrderDetails tables.
DECLARE @CustomerID INT;
SET @CustomerID = 1;  
DELETE FROM OrderDetails WHERE OrderID IN (SELECT OrderID FROM Orders WHERE CustomerID = @CustomerID);
DELETE FROM Orders WHERE CustomerID = @CustomerID;
GO
SELECT * FROM Orders, OrderDetails;

--Insert a new electronic gadget product into the Products table.
INSERT INTO Products (ProductName, Description, Price)
VALUES ('Super Gadget', 'Latest version of electronic gadget', 99.99); 
SELECT * FROM Products;
GO

--TASK 3
--Retrieve a list of all orders along with customer information (customer name) for each order
SELECT o.OrderID, c.FirstName, c.LastName, o.OrderDate, o.TotalAmount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID; -- inner join default (returns only  both rows are match)

--Find the total revenue generated by each electronic gadget product
SELECT p.ProductName, SUM(od.Quantity * p.Price) AS TotalRevenue
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID 
GROUP BY p.ProductName --compute revenue per product
ORDER BY TotalRevenue DESC; 

--List all customers who have made at least one purchase (include names and contact information).
SELECT DISTINCT c.CustomerID, c.FirstName, c.LastName, c.Email, c.Phone
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID;

--Find the most popular electronic gadget (highest total quantity ordered) 
SELECT TOP 1 p.ProductName, SUM(od.Quantity) AS TotalQuantityOrdered
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID --Inner join(only returns both rows are same)
GROUP BY p.ProductName
ORDER BY TotalQuantityOrdered DESC;

--Retrieve a list of electronic gadgets along with their corresponding categories.
ALTER TABLE Products ADD Category VARCHAR(100); --product doesnt has category
SELECT ProductName, Category FROM Products;

--Calculate the average order value for each customer
SELECT c.CustomerID, c.FirstName, c.LastName, AVG(o.TotalAmount) AS AvgOrderValue
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID -- inner join (order, customers)
GROUP BY c.CustomerID, c.FirstName, c.LastName;

-- Find the order with the highest total revenue
SELECT TOP 1 o.OrderID, c.FirstName, c.LastName, o.TotalAmount -- top 1
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID -- inner join
ORDER BY o.TotalAmount DESC; 

--List electronic gadgets and the number of times each product has been ordered
SELECT p.ProductName, COUNT(od.OrderID) AS OrderCount --counts the order id (no of order placed)
FROM OrderDetails od 
JOIN Products p ON od.ProductID = p.ProductID --innerjoin (products only been ordered)
GROUP BY p.ProductName --groups all the rows with same product name 
ORDER BY OrderCount DESC;

--Find customers who have purchased a specific electronic gadget.
SELECT DISTINCT c.CustomerID, c.FirstName, c.LastName, c.Email, c.Phone -- distinct(ensures product appear only once)
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.ProductName = 'Flowers';  

--Calculate the total revenue generated by all orders within a specific time period
UPDATE Orders SET OrderDate = '2024-01-01' WHERE OrderID = 1;
UPDATE Orders SET OrderDate = '2024-02-15' WHERE OrderID = 2;
UPDATE Orders SET OrderDate = '2024-03-10' WHERE OrderID = 3;

SELECT SUM(o.TotalAmount) AS TotalRevenue
FROM Orders o
WHERE o.OrderDate BETWEEN '2024-01-01' AND '2024-12-31'; 

--TASK 4

--Find customers who have NOT placed any orders
SELECT c.CustomerID, c.FirstName, c.LastName, c.Email, c.Phone 
FROM Customers c
WHERE c.CustomerID NOT IN (SELECT DISTINCT CustomerID FROM Orders); 
--subquery(Retrieves a distinct list of CustomerIDs from the Orders table)
--NOT IN - Excludes all customers who are found in the Orders table

--Find the total number of products available for sale
SELECT COUNT(*) AS TotalProducts FROM Products;

--Calculate the total revenue generated by TechShop
SELECT SUM(TotalAmount) AS TotalRevenue FROM Orders;

--Calculate the average quantity ordered for products in a specific category
SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Products';
-- retrives a list of all the  column name 

SELECT AVG(od.Quantity) AS AvgQuantityOrdered
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.Category = 'Flowers';

--Calculate the total revenue generated by a specific customer 
SELECT SUM(o.TotalAmount) AS CustomerRevenue
FROM Orders o
WHERE o.CustomerID = 1;  

--Find the customers who placed the most orders
SELECT TOP 1 o.CustomerID, c.FirstName, c.LastName, COUNT(o.OrderID) AS OrderCount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY o.CustomerID, c.FirstName, c.LastName
ORDER BY OrderCount DESC;

--Find the most popular product category (highest total quantity ordered)
SELECT p.Category, SUM(od.Quantity) AS TotalQuantityOrdered
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.Category
ORDER BY TotalQuantityOrdered DESC;

--Find the customer who has spent the most money on electronic gadgets
SELECT TOP 1 c.CustomerID, c.FirstName, c.LastName, SUM(o.TotalAmount) AS TotalSpent
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY TotalSpent DESC;

--Calculate the average order value (total revenue ÷ number of orders)
SELECT AVG(TotalAmount) AS AvgOrderValue FROM Orders;

-- Find the total number of orders placed by each customer
SELECT c.CustomerID, c.FirstName, c.LastName, COUNT(o.OrderID) AS OrderCount
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY OrderCount DESC;













