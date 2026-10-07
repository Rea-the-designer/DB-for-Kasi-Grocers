/*
Name                : Reatlehile
Surname             : Leeto
Module Code         : ITSSA0-33 
Project Description : Building the Sales & Loyalty Database
*/


-- Question 1.1: Creating a database

CREATE DATABASE KasiFreshGrocersDB;
GO

USE KasiFreshGrocersDB;
GO

-- Question 1.2: Create Tables, Primary Keys, & Foreign Keys

-- Creating a table for Suppliers

CREATE TABLE Suppliers(
	SupplierID INT IDENTITY(1,1),
	SupplierName VARCHAR (40) NOT NULL,
	ContactEmail VARCHAR (40) NOT NULL,
	Province VARCHAR (30) NOT NULL,
	PRIMARY KEY (SupplierID)
);
GO

-- Creating a table for Branches

CREATE TABLE Branches(
	BranchID INT IDENTITY (1,1),
	BranchName VARCHAR (40) NOT NULL,
	Township VARCHAR (50) NOT NULL,
	Province VARCHAR (50) NOT NULL,
	ManagerName VARCHAR (40) NOT NULL,
	PRIMARY KEY (BranchID)
);
GO

-- Creating a table for Products

CREATE TABLE Products(
	ProductID INT IDENTITY (1,1),
	ProductName VARCHAR (50) NOT NULL,
	Category VARCHAR (50) NOT NULL,
	UnitPrice DECIMAL (10,2) NOT NULL,
	SupplierID INT NOT NULL,
	PRIMARY KEY (ProductID) ,
	CONSTRAINT FK_Products_Suppliers FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);
GO

-- Creating a table for Customers

CREATE TABLE Customers(
	CustomerID INT IDENTITY (1,1),
	FirstName VARCHAR (50) NOT NULL,
	LastName VARCHAR (50) NOT NULL,
	Email VARCHAR (40) NOT NULL,
	Phone VARCHAR(20) NOT NULL,
	LoyaltyTier VARCHAR (20) DEFAULT 'Bronze',
	LoyaltyPoints INT DEFAULT 0,
	SignupDate DATE NOT NULL,
	PRIMARY KEY (CustomerID)
);
GO

-- Creating a table for Orders

CREATE TABLE Orders(
	OrderID INT IDENTITY (1,1),
	CustomerID INT NOT NULL,
	BranchID INT NOT NULL,
	OrderDate DATE NOT NULL,
	PaymentMethod VARCHAR(50),
	PRIMARY KEY (OrderID),
	CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
	CONSTRAINT FK_Orders_Branches FOREIGN KEY (BranchID) REFERENCES Branches(BranchID)
);
GO

-- Creating a table for OrderItems

CREATE TABLE OrderItems(
	OrderItemID INT IDENTITY (1,1),
	OrderID INT NOT NULL,
	ProductID INT NOT NULL,
	Quantity INT NOT NULL,
	UnitPrice DECIMAL (10,2) NOT NULL,
	PRIMARY KEY (OrderItemID),
	CONSTRAINT FK_OrderItems_Orders FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
	CONSTRAINT FK_OrderItems_Products FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
GO

-- Question 1.3: Populating data in tables

-- Populating Suppliers table

INSERT INTO Suppliers ( SupplierName, ContactEmail, Province) VALUES
( 'Sunripe Produce', 'order@sunripe.co.za', 'Gauteng'),
( 'Cape Fresh Logistics', 'info@capefresh.co.za', 'Western Cape'),
( 'KZN Dairy Distributors', 'sales@kzndairy.co.za', 'KwaZulu-Natal'),
( 'Eastern Cape Meats', 'contact@ecmeats.co.za', 'Eastern Cape'),
( 'Highveld Grain Co', 'support@highveldgrain.co.za', 'Gauteng'),
( 'Kalahari Poultry', 'orders@kalaharipoultry.co.za', 'Northern Cape'),
( 'Limpopo Citrus Growers', 'sales@limpopocitrus', 'Limpopo'),
( 'Mpumalanga Bakery Supplies', 'info@mputbakery.co.za', 'Mpumalanga');

-- Populating Branches table

INSERT INTO Branches ( BranchName, Township, Province, ManagerName) VALUES
( 'Soweto Central', 'Soweto', 'Gauteng', 'Sibusiso Khumalo'),
( 'Alexandra Express', 'Alexandra', 'Gauteng', 'Lerato Kgosi'),
( 'Khayelitsha Hub', 'Khayelitsha', 'Western Cape', 'Sipho Ndlovu'),
( 'Umlazi Plaza', 'Umlazi', 'KwaZulu-Natal', 'Thandiwe Zungu'),
( 'Mamelodi Mart', 'Mamelodi', 'Gauteng', 'Kabo Mabena'),
( 'Mdantsane Fresh', 'Mdantsane', 'Eastern Cape', 'Nomsa Dlamini'),
( 'Tembisa Square', 'Tembisa', 'Gauteng', 'Jabu Mokoena'),
( 'Galeshewe Corner', 'Galeshewe', 'Northern Cape', 'Boitumelo Van Wyk');

-- Populating Products table

INSERT INTO Products ( ProductName, Category, UnitPrice, SupplierID) VALUES
( 'Full Cream Milk 2L', 'Dairy', 34.99, 3),
( 'White Bread 700g', 'Bakery' , 16.50, 8),
( 'Chicken Potion 2kg', 'Meat' , 89.90, 6),
( 'Maize Meal 10kg', 'Staples' , 115.00, 5),
( 'Fresh Bananas 1kg', 'Produce' , 22.99, 1),
( 'Apples 1.5kg Bag', 'Produce' , 29.99, 7),
( 'Cheddar Cheese 500g', 'Dairy' , 64.50, 3),
( 'Beef Mince 1kg', 'Meat' , 95.00, 4);

-- Populating Customers table

INSERT INTO Customers (FirstName, LastName, Email, Phone, LoyaltyTier, SignupDate)VALUES
('Tebogo', 'Mokoena', 'tebogo.m@example.com', '0821234567', 'Gold', '2025-01-15'),
('Nkosana', 'Dlamini', 'nkosana.d@example.com', '0832345678', 'Silver', '2025-03-20'),
('Ayanda', 'Sithole', 'ayanda.s@example.com', '0843456789', 'Bronze', '2025-06-10'),
('Zanele', 'Nxumalo', 'zanele.n@example.com', '0824557890', 'Bronze', '2026-01-05'),
('Kagisho', 'Molefe', 'kagisho.m@example.com', '0815678901', 'Bronze', '2026-02-14'),
('Lindiwe', 'Zulu', 'lindiwe.z@example.com', '0836789012', 'Silver', '2026-03-01'),
('Thabo', 'Mbeki', 'thabo.m@example.com', '0827890123', 'Bronze', '2026-06-15'),
('Bontle', 'Modise', 'bontle.m@example.com', '0848901234', 'Bronze', '2026-07-01');

-- Populating Orders table

INSERT INTO Orders (CustomerID, BranchID, OrderDate, PaymentMethod)VALUES
(1, 1, '2026-07-20', 'Cash'),
(2, 2, '2026-07-21', 'Card'),
(3, 3, '2026-02-10', 'EFT'),    -- Inactive > 90 days relative to July 2026
(4, 4, '2026-01-15', 'Cash'),   -- Inactive > 90 days relative to July 2026
(1, 1, '2026-07-25', 'Card'),
(5, 5, '2026-07-22', 'Cash'),
(6, 6, '2026-07-24', 'Store Card'),
(7, 7, '2026-03-01', 'Cash');      -- Inactive > 90 days relative to July 2026

-- Populating OrderItems table

INSERT INTO OrderItems(OrderID, ProductID, Quantity, UnitPrice)VALUES
(1, 1, 2, 34.99),
(1, 2, 1, 16.50),
(2, 3, 1, 89.90),
(3, 4, 3, 115.00),
(4, 5, 2, 22.99),
(5, 8, 1, 95.00),
(6, 6, 2, 29.99),
(7, 7, 1, 64.50);
GO

-- Question 1.4: Using SELECT Queries with WHERE, ORDER BY, & Aggregates functions 

--(a)Calculating total revenue per branch
SELECT 
	b.BranchName,
	b.Township,
	SUM(oi.Quantity * oi.UnitPrice) AS TotalRevenue
FROM Branches b
JOIN Orders o ON b.BranchID =	o.BranchID
JOIN OrderItems oi ON o.OrderID = oi.OrderID
GROUP BY b.BranchName, b.Township
ORDER BY TotalRevenue DESC;
GO

--(b) Customers who have not ordered in the last 90 days
SELECT
	c.CustomerID,
	c.FirstName,
	c.LastName,
	MAX(o.OrderDate) AS LastOrderDate
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName
HAVING MAX(o.OrderDate) < DATEADD(DAY, -90, GETDATE()) OR MAX(o.OrderDate) IS NULL
ORDER BY LastOrderDate ASC;
GO

-- Question 1.5: Creating a Non-clustered index & trigger

-- Non-clustered index on foreign key Orders.CoustomerID
CREATE NONCLUSTERED INDEX IX_Orders_CustomerID
ON Orders (CustomerID);
GO

-- Making a Trigger on OrderItems to prevent negative quantities
CREATE TRIGGER trg_ValidateQuantity
ON OrderItems
AFTER INSERT, UPDATE
AS 
BEGIN
	SET NOCOUNT ON;

	IF EXISTS (SELECT 1 FROM inserted WHERE Quantity <= 0)
	BEGIN
		RAISERROR ('Quantity must be greater than zero.', 16, 1);
		ROLLBACK TRANSACTION;
	END
END;
GO

-- Question 1.6: Creating a combined sales report view

CREATE VIEW vw_SalesSummary AS
SELECT
	o.OrderID,
	c.FirstName + ' ' + c.LastName AS CustomerName,
	p.ProductName,
	oi.Quantity,
	oi.UnitPrice,
	(oi.Quantity * oi.UnitPrice) AS LineTotal
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN OrderItems oi ON o.OrderID = oi.OrderID
JOIN Products p ON oi.ProductID = p.ProductID;
GO

-- Question 1.7: A Stored Procedure (Iteration, TRY...CATCH) & Security

-- A stored procedure calculating loyalty points using a CURSOR with TRY....CATCH

CREATE PROCEDURE sp_CalculateLoyaltyPoints
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
	DECLARE @CustID INT;
	DECLARE @TotalSpend DECIMAL(10,2);
	DECLARE @CalculatedPoints INT;

	-- Cursor to iterate through each customer
	DECLARE customer_cursor CURSOR FOR
		SELECT c.CustomerID
		FROM Customers c;

	OPEN customer_cursor;

	FETCH NEXT FROM customer_cursor INTO @CustID;

	WHILE @@FETCH_STATUS = 0
	BEGIN 
		    -- Calculate total spend for the current customer
		    SELECT @TotalSpend = ISNULL(SUM(oi.Quantity * oi.UnitPrice), 0)
		    FROM Orders o
		    JOIN OrderItems oi ON o.OrderID = oi.OrderID
		    WHERE O.CustomerID = @CustID;

		    -- 1 Points earned for every R10 spent
		    SET @CalculatedPoints = CAST(@TotalSpend / 10 AS INT);

		    -- Update customer record
		    UPDATE Customers
		    SET LoyaltyPoints = @CalculatedPoints
		    WHERE CustomerID = @CustID;

		    FETCH NEXT FROM customer_cursor INTO @CustID;
	    END

	    CLOSE customer_cursor;
	    DEALLOCATE customer_cursor;

	    PRINT 'Loyalty points calculated and updated successfully.';
    END TRY
    BEGIN CATCH
	     --It will handle errors gracefully
	    IF CURSOR_STATUS('global', 'customer_cursor') >= -1
	    BEGIN
		    CLOSE customer_cursor;
		    DEALLOCATE customer_cursor;
	    END

	    PRINT 'Érror encountered during loyalty points calculation: ' + ERROR_MESSAGE();
    END CATCH
END;

-- Question 1.8 (Security): Create Read-Only Login & User

-- Creating a Server Login
CREATE LOGIN Rea WITH PASSWORD = 'Reatlehile$45%!'
GO

-- Create Database User for the Login[cite: 1]
CREATE USER Rea FOR LOGIN Rea;
GO

-- Grant SELECT permissions only (Read-Only)[cite: 1]
GRANT SELECT TO Rea;
GO