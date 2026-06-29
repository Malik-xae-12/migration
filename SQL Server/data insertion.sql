USE MigrationTestDB;
GO

--------------------------------------------------
-- Delete data
--------------------------------------------------
DELETE FROM OrderDetails;
DELETE FROM Orders;
DELETE FROM Products;
DELETE FROM Employees;
DELETE FROM Customers;

--------------------------------------------------
-- Customers (IncLoadType = 2)
--------------------------------------------------
INSERT INTO Customers
(CustomerName,Email,Phone,City,CreatedDate)
VALUES
('John','john@gmail.com','9000000001','Hyderabad','2026-06-28 10:00:00'),
('Alice','alice@gmail.com','9000000002','Chennai','2026-06-28 10:05:00');

--------------------------------------------------
-- Products (IncLoadType = 3)
--------------------------------------------------
INSERT INTO Products
(ProductName,Category,Price,ModifiedDate)
VALUES
('Laptop','Electronics',50000,'2026-06-28 10:10:00'),
('Mouse','Electronics',1000,'2026-06-28 10:15:00');

--------------------------------------------------
-- Employees (Full Load)
--------------------------------------------------
INSERT INTO Employees
(EmployeeName,Department,Salary,JoiningDate)
VALUES
('Robert','IT',70000,'2025-01-01'),
('David','HR',60000,'2025-02-01');

--------------------------------------------------
-- Orders (IncLoadType = 4)
--------------------------------------------------
INSERT INTO Orders
(CustomerID,EmployeeID,OrderDate,TotalAmount,CreatedDate,ModifiedDate)
VALUES
(1,1,'2026-06-28 10:20:00',10000,'2026-06-28 10:20:00','2026-06-28 10:20:00'),
(2,2,'2026-06-28 10:25:00',15000,'2026-06-28 10:25:00','2026-06-28 10:25:00');

--------------------------------------------------
-- OrderDetails (Full Load)
--------------------------------------------------
INSERT INTO OrderDetails
(OrderID,ProductID,Quantity,UnitPrice)
VALUES
(1,1,1,50000),
(2,2,2,1000);



USE TestDB;
GO

--=========================================
-- Drop Tables (if already exist)
--=========================================
IF OBJECT_ID('dbo.Orders', 'U') IS NOT NULL
    DROP TABLE dbo.Orders;

IF OBJECT_ID('dbo.Customers', 'U') IS NOT NULL
    DROP TABLE dbo.Customers;
GO

--=========================================
-- Create Customers Table
--=========================================
CREATE TABLE dbo.Customers
(
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerName NVARCHAR(100),
    Email NVARCHAR(150),
    City NVARCHAR(100),
    CreatedDate DATETIME DEFAULT GETDATE(),
    ModifiedDate DATETIME NULL
);
GO

--=========================================
-- Create Orders Table
--=========================================
CREATE TABLE dbo.Orders
(
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT,
    OrderDate DATETIME,
    TotalAmount DECIMAL(10,2),
    Status NVARCHAR(50),
    ModifiedDate DATETIME NULL,

    CONSTRAINT FK_Orders_Customers
        FOREIGN KEY(CustomerID)
        REFERENCES dbo.Customers(CustomerID)
);
GO

--=========================================
-- Insert Customers
--=========================================
INSERT INTO dbo.Customers
(
    CustomerName,
    Email,
    City,
    CreatedDate,
    ModifiedDate
)
VALUES
('John Smith','john@gmail.com','Hyderabad',GETDATE(),GETDATE()),
('Alice Johnson','alice@gmail.com','Bangalore',GETDATE(),GETDATE()),
('David Miller','david@gmail.com','Chennai',GETDATE(),GETDATE()),
('Sophia Brown','sophia@gmail.com','Mumbai',GETDATE(),GETDATE()),
('Michael Lee','michael@gmail.com','Pune',GETDATE(),GETDATE());

GO

--=========================================
-- Insert Orders
--=========================================
INSERT INTO dbo.Orders
(
    CustomerID,
    OrderDate,
    TotalAmount,
    Status,
    ModifiedDate
)
VALUES
(1,GETDATE(),1500.00,'Completed',GETDATE()),
(2,GETDATE(),2300.50,'Pending',GETDATE()),
(3,GETDATE(),980.75,'Completed',GETDATE()),
(4,GETDATE(),4200.00,'Cancelled',GETDATE()),
(5,GETDATE(),3150.25,'Shipped',GETDATE());

GO

--=========================================
-- Verify Data
--=========================================
SELECT * FROM dbo.Customers;
SELECT * FROM dbo.Orders;