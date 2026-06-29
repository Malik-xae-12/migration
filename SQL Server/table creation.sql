CREATE DATABASE MigrationTestDB;
GO

USE MigrationTestDB;
GO

/*==========================================================
1. Customers
IncLoadType = 2 (CreatedDate)
==========================================================*/
CREATE TABLE Customers
(
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(200),
    Phone NVARCHAR(20),
    City NVARCHAR(100),
    CreatedDate DATETIME2 NOT NULL
);
GO

/*==========================================================
2. Products
IncLoadType = 3 (ModifiedDate)
==========================================================*/
CREATE TABLE Products
(
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(150) NOT NULL,
    Category NVARCHAR(100),
    Price DECIMAL(18,2),
    ModifiedDate DATETIME2 NOT NULL
);
GO

/*==========================================================
3. Employees
Full Load
==========================================================*/
CREATE TABLE Employees
(
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeName NVARCHAR(100) NOT NULL,
    Department NVARCHAR(100),
    Salary DECIMAL(18,2),
    JoiningDate DATE
);
GO

/*==========================================================
4. Orders
IncLoadType = 4 (CreatedDate + ModifiedDate)
==========================================================*/
CREATE TABLE Orders
(
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    EmployeeID INT NOT NULL,
    OrderDate DATETIME2 NOT NULL,
    TotalAmount DECIMAL(18,2),
    CreatedDate DATETIME2 NOT NULL,
    ModifiedDate DATETIME2 NOT NULL,

    CONSTRAINT FK_Orders_Customers
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID),

    CONSTRAINT FK_Orders_Employees
        FOREIGN KEY (EmployeeID)
        REFERENCES Employees(EmployeeID)
);
GO

/*==========================================================
5. OrderDetails
Full Load
==========================================================*/
CREATE TABLE OrderDetails
(
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(18,2) NOT NULL,

    CONSTRAINT FK_OrderDetails_Orders
        FOREIGN KEY (OrderID)
        REFERENCES Orders(OrderID),

    CONSTRAINT FK_OrderDetails_Products
        FOREIGN KEY (ProductID)
        REFERENCES Products(ProductID)
);
GO