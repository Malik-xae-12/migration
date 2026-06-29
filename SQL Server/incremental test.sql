USE MigrationTestDB;
GO

--------------------------------------------------
-- New Customer
--------------------------------------------------
INSERT INTO Customers
(CustomerName,Email,Phone,City,CreatedDate)
VALUES
('Chris','chris@gmail.com','9000000003','Delhi',
'2026-06-29 09:00:00');

--------------------------------------------------
-- Update Product
--------------------------------------------------
UPDATE Products
SET
Price=55000,
ModifiedDate='2026-06-29 09:05:00'
WHERE ProductID=1;

--------------------------------------------------
-- Update Order
--------------------------------------------------
UPDATE Orders
SET
TotalAmount=12000,
ModifiedDate='2026-06-29 09:10:00'
WHERE OrderID=1;

--------------------------------------------------
-- New Order
--------------------------------------------------
INSERT INTO Orders
(CustomerID,EmployeeID,OrderDate,TotalAmount,CreatedDate,ModifiedDate)
VALUES
(1,2,
'2026-06-29 09:15:00',
18000,
'2026-06-29 09:15:00',
'2026-06-29 09:15:00');

--------------------------------------------------
-- OrderDetails (Full Load)
--------------------------------------------------
INSERT INTO OrderDetails
(OrderID,ProductID,Quantity,UnitPrice)
VALUES
(3,1,1,55000);

--------------------------------------------------
-- Employees (Full Load)
--------------------------------------------------
INSERT INTO Employees
(EmployeeName,Department,Salary,JoiningDate)
VALUES
('Tony','Finance',80000,'2025-03-01');