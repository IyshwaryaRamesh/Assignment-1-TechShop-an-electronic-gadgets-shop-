task 1
CREATE DATABASE TechShop;
GO
USE TechShop;
GO
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(50),
    Phone VARCHAR(20),
    Address VARCHAR(200)
);
GO

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Description VARCHAR(200),
    Price INT
);
GO

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount INT DEFAULT 0,
    CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE
);
GO

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    CONSTRAINT FK_OrderDetails_Products FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
GO

CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY,
    ProductID INT UNIQUE,
    QuantityInStock INT,
    LastStockUpdate DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Inventory_Products FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
GO
exec sp_columns Customers;
exec sp_columns Orders;
exec sp_columns OrderDetails;
exec sp_columns Inventory;
exec sp_columns Products;
GO
INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Phone, Address)
VALUES 
(1, 'Alice', 'Green', 'alice.green@email.com', '555-1234', '12 Forest Road'),
(2, 'Ben', 'White', 'ben.white@email.com', '555-5678', '34 Riverbank Ave'),
(3, 'Catherine', 'Brown', 'catherine.brown@email.com', '555-8765', '56 Ocean View Dr'),
(4, 'David', 'Black', 'david.black@email.com', '555-4321', '78 Mountain Ridge Blvd'),
(5, 'Eva', 'Blue', 'eva.blue@email.com', '555-6789', '90 Sunset Hill St'),
(6, 'Frank', 'Silver', 'frank.silver@email.com', '555-9876', '123 Cedar Grove'),
(7, 'Grace', 'Gold', 'grace.gold@email.com', '555-2345', '45 Lakeview Dr'),
(8, 'Hannah', 'Yellow', 'hannah.yellow@email.com', '555-3456', '67 Pine Crest Rd'),
(9, 'Ian', 'Red', 'ian.red@email.com', '555-5679', '89 Birchwood Ln'),
(10, 'Jack', 'Purple', 'jack.purple@email.com', '555-6780', '101 Maple Hollow');

GO

INSERT INTO Products (ProductID, ProductName, Description, Price)
VALUES 
(1, 'Laptop', 'i7 laptop', 7200),
(2, 'Smartphone', '%G smartphone', 40000),
(3, 'Tablet', '9-inch screen tablet', 30000),
(4, 'Smartwatch', 'Wearable OLED smartwatch', 2500),
(5, 'Earphones', 'Noise-canceling Earphones', 1500),
(6, 'Keyboard', 'Wireless keyboard', 1000),
(7, 'Mouse', 'Wireless mouse', 500),
(8, 'Monitor', '23-inch LED monitor', 2000),
(9, 'Speakers', 'Bluetooth speakers', 1800),
(10, 'External HDD', '500GB external hard drive', 9000);

INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES 
(1, 1, '2025-03-01', 2400),
(2, 2, '2025-03-02', 1600),
(3, 3, '2025-03-03', 800),
(4, 4, '2025-03-04', 250),
(5, 5, '2025-03-05', 300),
(6, 6, '2025-03-06', 1200),
(7, 7, '2025-03-07', 400),
(8, 8, '2025-03-08', 500),
(9, 9, '2025-03-09', 150),
(10, 10, '2025-03-10', 90);
go

INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity)
VALUES 
(1, 1, 1, 2),  
(2, 2, 2, 2), 
(3, 3, 3, 1), 
(4, 4, 4, 1), 
(5, 5, 5, 2),  
(6, 6, 1, 1),  
(7, 7, 6, 2),  
(8, 8, 7, 5), 
(9, 9, 5, 1), 
(10, 10, 10, 1); 
GO

INSERT INTO Inventory (InventoryID, ProductID, QuantityInStock, LastStockUpdate)
VALUES 
(1, 1, 50, '2025-03-01'),
(2, 2, 100, '2025-03-02'),
(3, 3, 30, '2025-03-03'),
(4, 4, 25, '2025-03-04'),
(5, 5, 60, '2025-03-05'),
(6, 6, 70, '2025-03-06'),
(7, 7, 90, '2025-03-07'),
(8, 8, 40, '2025-03-08'),
(9, 9, 55, '2025-03-09'),
(10, 10, 80, '2025-03-10');
GO

SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Orders;
SELECT * FROM OrderDetails;
SELECT * FROM Inventory;
GO

task 2

SELECT FirstName, LastName, Email FROM Customers;

SELECT Orders.OrderID, Orders.OrderDate, Customers.FirstName, Customers.LastName 
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

UPDATE Customers
SET FirstName = 'Reshhma', LastName = 'Ramesh', Email = 'reshhmaramesh@gmail.com', Phone = '8590441738', Address = '123 Main, Trivandrum, India'
WHERE CustomerID = 12;


UPDATE Products 
SET Price = Price * 1.10 
WHERE Description LIKE '%electronic%';

DELETE FROM dbo.OrderDetails  
WHERE OrderID = 3;  

DELETE FROM dbo.Orders  
WHERE OrderID = 3;

 insert into Orders(OrderID, CustomerID, OrderDate, TotalAmount)
values
(10, 10, '2025-03-11', 900.87);

 update dbo.Customers
set Email='abc@example.com',
	Address= '123 New Street, palara,Trivandrum'
	where CustomerID=1;

 UPDATE Orders 
SET TotalAmount = (
    SELECT SUM(Products.Price * OrderDetails.Quantity) 
    FROM OrderDetails 
    JOIN Products ON OrderDetails.ProductID = Products.ProductID 
    WHERE OrderDetails.OrderID = Orders.OrderID
);

DELETE FROM OrderDetails WHERE OrderID IN (SELECT OrderID FROM Orders WHERE CustomerID = 101);
DELETE FROM Orders WHERE CustomerID = 101;

INSERT INTO Products (ProductID,ProductName,Description, Price) 
VALUES (11,'Smartphone X', 'Latest electronic smartphone with AI features', 569.99);

 UPDATE Orders 
SET TotalAmount = '900'
WHERE OrderID = '11';

 UPDATE Customers 
SET FirstName = (
    SELECT COUNT(*) 
    FROM Orders 
    WHERE Orders.CustomerID = Customers.CustomerID
);
--Task 3
--q1
SELECT o.OrderID, o.OrderDate, o.TotalAmount, 
       c.FirstName, c.LastName, c.Email, c.Phone, c.Address
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID;

--q2
SELECT p.ProductName, SUM(od.Quantity * p.Price) AS TotalRevenue
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY TotalRevenue DESC;

--q3
SELECT DISTINCT c.FirstName, c.LastName, c.Email, c.Phone
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NOT NULL;

--q4
SELECT TOP 1 p.ProductName, SUM(od.Quantity) AS TotalQuantityOrdered
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY TotalQuantityOrdered DESC;

--q5
SELECT ProductName, 
       CASE 
           WHEN Description LIKE '%laptop%' THEN 'Laptop'
           WHEN Description LIKE '%smartphone%' THEN 'Smartphone'
           WHEN Description LIKE '%tablet%' THEN 'Tablet'
           WHEN Description LIKE '%smartwatch%' THEN 'Smartwatch'
           WHEN Description LIKE '%earphone%' THEN 'Audio'
           WHEN Description LIKE '%keyboard%' OR Description LIKE '%mouse%' THEN 'Computer Accessories'
           WHEN Description LIKE '%monitor%' THEN 'Display'
           WHEN Description LIKE '%speaker%' THEN 'Audio'
           WHEN Description LIKE '%HDD%' THEN 'Storage'
           ELSE 'Other Electronics'
       END AS Category
FROM Products;

--q6
SELECT c.FirstName, c.LastName, AVG(o.TotalAmount) AS AverageOrderValue
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName;

--q7
SELECT TOP 1 o.OrderID, c.FirstName, c.LastName, c.Email, o.TotalAmount AS TotalRevenue
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
ORDER BY o.TotalAmount DESC;

--q8
SELECT p.ProductName, COUNT(od.OrderDetailID) AS TimesOrdered
FROM Products p
LEFT JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY TimesOrdered DESC;

--q9
DECLARE @ProductName VARCHAR(100) = 'Laptop';

SELECT DISTINCT c.FirstName, c.LastName, c.Email, c.Phone
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.ProductName = @ProductName;

--q10
DECLARE @StartDate DATETIME = '2025-03-01';
DECLARE @EndDate DATETIME = '2025-03-10';

SELECT SUM(o.TotalAmount) AS TotalRevenue
FROM Orders o
WHERE o.OrderDate BETWEEN @StartDate AND @EndDate;

Task 4

--q1
SELECT c.FirstName, c.LastName, c.Email, c.Phone
FROM Customers c
WHERE c.CustomerID NOT IN (
    SELECT DISTINCT CustomerID 
    FROM Orders
);

--q2
SELECT COUNT(*) AS TotalProductsAvailable
FROM Products;

--q3
SELECT SUM(TotalAmount) AS TotalRevenue
FROM Orders;

--q4
DECLARE @CategoryName VARCHAR(50) = 'Laptop';
SELECT AVG(od.Quantity) AS AverageQuantityOrdered
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.ProductName LIKE '%' + @CategoryName + '%';

--q5
DECLARE @CustomerID INT = 1; -- Example parameter

SELECT SUM(o.TotalAmount) AS TotalCustomerRevenue
FROM Orders o
WHERE o.CustomerID = @CustomerID;

--q6
SELECT TOP 1 c.FirstName, c.LastName, COUNT(o.OrderID) AS NumberOfOrders
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName
ORDER BY NumberOfOrders DESC;

--q7
SELECT TOP 1 
    CASE 
        WHEN p.ProductName LIKE '%laptop%' THEN 'Laptop'
        WHEN p.ProductName LIKE '%smartphone%' THEN 'Smartphone'
        WHEN p.ProductName LIKE '%tablet%' THEN 'Tablet'
        WHEN p.ProductName LIKE '%smartwatch%' THEN 'Smartwatch'
        WHEN p.ProductName LIKE '%earphone%' THEN 'Audio'
        WHEN p.ProductName LIKE '%keyboard%' OR p.ProductName LIKE '%mouse%' THEN 'Computer Accessories'
        WHEN p.ProductName LIKE '%monitor%' THEN 'Display'
        WHEN p.ProductName LIKE '%speaker%' THEN 'Audio'
        WHEN p.ProductName LIKE '%HDD%' THEN 'Storage'
        ELSE 'Other Electronics'
    END AS Category,
    SUM(od.Quantity) AS TotalQuantityOrdered
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY 
    CASE 
        WHEN p.ProductName LIKE '%laptop%' THEN 'Laptop'
        WHEN p.ProductName LIKE '%smartphone%' THEN 'Smartphone'
        WHEN p.ProductName LIKE '%tablet%' THEN 'Tablet'
        WHEN p.ProductName LIKE '%smartwatch%' THEN 'Smartwatch'
        WHEN p.ProductName LIKE '%earphone%' THEN 'Audio'
        WHEN p.ProductName LIKE '%keyboard%' OR p.ProductName LIKE '%mouse%' THEN 'Computer Accessories'
        WHEN p.ProductName LIKE '%monitor%' THEN 'Display'
        WHEN p.ProductName LIKE '%speaker%' THEN 'Audio'
        WHEN p.ProductName LIKE '%HDD%' THEN 'Storage'
        ELSE 'Other Electronics'
    END
ORDER BY TotalQuantityOrdered DESC;

--q8
SELECT TOP 1 c.FirstName, c.LastName, SUM(o.TotalAmount) AS TotalSpending
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IN (
    SELECT od.OrderID
    FROM OrderDetails od
    JOIN Products p ON od.ProductID = p.ProductID
    WHERE p.Description LIKE '%electronic%' OR p.ProductName LIKE '%electronic%'
)
GROUP BY c.FirstName, c.LastName
ORDER BY TotalSpending DESC;

--q9
SELECT AVG(TotalAmount) AS AverageOrderValue
FROM Orders;

--q10
SELECT c.FirstName, c.LastName, COUNT(o.OrderID) AS OrderCount
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName
ORDER BY OrderCount DESC;