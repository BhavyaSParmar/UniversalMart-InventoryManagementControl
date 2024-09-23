--Performing Encryption on Customer Table--

alter table Customer add Customer_Username varchar(50), [Customer_Password]  varbinary(400)

create MASTER KEY
ENCRYPTION BY PASSWORD = 'Damg123456^';

-- SELECT name KeyName,
--   symmetric_key_id KeyID,
--   key_length KeyLength,
--   algorithm_desc KeyAlgorithm
-- FROM sys.symmetric_keys;


CREATE CERTIFICATE CustomerPass  
   WITH SUBJECT = 'Customer Sample Password';  
GO  

CREATE SYMMETRIC KEY CustomerPass_SM 
    WITH ALGORITHM = AES_256  
    ENCRYPTION BY CERTIFICATE CustomerPass;  
GO  

OPEN SYMMETRIC KEY CustomerPass_SM  
   DECRYPTION BY CERTIFICATE CustomerPass;

UPDATE Customer set [Customer_Username] = Email_ID
, [Customer_Password] = EncryptByKey(Key_GUID('CustomerPass_SM'),  convert(varbinary,'ProjectTeam@123')  ) 
GO  

SELECT *, 
    CONVERT(varchar, DecryptByKey([Customer_Password]))   
    AS 'Decrypted password'  
    FROM Customer;  
GO  
---------------------------------------------------------------------------------------------------------------

--Procedure 1 Insert New Customer--
CREATE PROCEDURE InsertNewCustomer (
    @Customer_ID VARCHAR(20),
    @First_Name VARCHAR(50),
    @Last_Name VARCHAR(50),
    @Email_ID VARCHAR(50),
    @Phone_Number INT,
    @Customer_Street VARCHAR(50),
    @Customer_City VARCHAR(50),
    @Customer_State VARCHAR(2),
    @Customer_Status VARCHAR(20),
    @Join_Date DATE
)
AS
BEGIN
    INSERT INTO Customer (
        Customer_ID, First_Name, Last_Name,
        Email_ID, Phone_Number, Customer_Street,
        Customer_City, Customer_State, Customer_Status,
        Join_Date
    )
    VALUES (
        @Customer_ID, @First_Name, @Last_Name, @Email_ID,
        @Phone_Number, @Customer_Street, @Customer_City,
        @Customer_State, @Customer_Status, @Join_Date
    );
END;

--Procedure 2 Update Inventory Category--

CREATE PROCEDURE UpdateInventoryCategory (@Inventory_ID VARCHAR(20),@NewCategory VARCHAR(100))
AS
BEGIN
    UPDATE Inventory
    SET Inventory_Category = @NewCategory
    WHERE Inventory_ID = @Inventory_ID;

    PRINT CONCAT('Inventory category for ', @Inventory_ID, ' updated to ', @NewCategory);
END;

--Procedure 3 Update Product Name and Description--

CREATE PROCEDURE UpdateProductNameAndDescription
    @p_ProductID VARCHAR(20),
    @p_NewName VARCHAR(100) OUTPUT,
    @p_NewDescription VARCHAR(100) OUTPUT
AS
BEGIN
   
    IF NOT EXISTS (SELECT 1 FROM Product WHERE Product_ID = @p_ProductID)
    BEGIN
        PRINT ('Product does not exist');
        RETURN;
    END

    UPDATE Product
    SET
        Product_Name = @p_NewName,
        Product_Description = @p_NewDescription
    OUTPUT
        INSERTED.Product_Name,
        INSERTED.Product_Description
    WHERE Product_ID = @p_ProductID;

    SELECT @p_NewName = Product_Name, @p_NewDescription = Product_Description
    FROM Product
    WHERE Product_ID = @p_ProductID;

    PRINT CONCAT('Product details updated for ', @p_ProductID);
END;

DECLARE @NewName VARCHAR(100);
DECLARE @NewDescription VARCHAR(100);

EXEC UpdateProductNameAndDescription 
    @p_ProductID = 'P001',
    @p_NewName = iPhone,
    @p_NewDescription = 'High-End Smartphone';

--Procedure 4 Get Customer Order Details--

CREATE PROCEDURE GetOrdersDetailByCustomer
    @cusID VARCHAR(20)
AS
BEGIN
    IF EXISTS(SELECT 1 FROM Customer WHERE Customer_ID = @cusID)
    BEGIN
        SELECT c.Customer_ID, c.First_Name, c.Last_Name, dbo.GetDiscountedPrice(p.Amount, p.Discount) AS 'Final Amount' FROM Customer c
        JOIN Orders o ON c.Customer_ID = o.Customer_ID
        JOIN Invoice i on o.Invoice_ID = i.Invoice_ID
        JOIN Payment_Details p on i.Payment_ID = p.Payment_ID
        WHERE c.Customer_ID = @cusID;
    END
    ELSE
    BEGIN
        SELECT 'Customer Does Not Exists';
    END
END

EXEC GetOrdersDetailByCustomer 'C002';

--Procedure 5 Product Stock Information--

CREATE PROCEDURE GetStockInformationByProduct
    @prodID VARCHAR(20)
AS
BEGIN
    IF EXISTS(SELECT 1 FROM Product_Inventory WHERE Product_ID = @prodID)
    BEGIN
        SELECT 
            p.Product_Name,
            p.Product_Price,
            c.Category_Name,
            PI.Product_Location,
            PI.Product_Received_Date,
            PI.Product_Stock_Count,
            i.Inventory_Category
        FROM Product_Inventory PI
        JOIN Inventory i ON PI.Inventory_ID = i.Inventory_ID
        JOIN Product p ON PI.Product_ID = p.Product_ID
        JOIN Category c ON p.Category_ID = c.Category_ID
        WHERE PI.Product_ID = @prodID;
    END
    ELSE
    BEGIN
        SELECT NULL
    END
END;

EXEC GetStockInformationByProduct 'P002';

--Procedure 6 Total Revenue (Customer wise)--

CREATE PROCEDURE GetTotalRevenueByCustomer
    @cusID VARCHAR(20)
AS
BEGIN
    IF EXISTS(SELECT 1 FROM Customer WHERE Customer_ID = @cusID)
    BEGIN
        SELECT c.Customer_ID, c.Customer_Username, c.First_Name, c.Last_Name, dbo.GetDiscountedPrice(SUM(p.Amount), SUM(p.Discount)) AS 'Total Amount' FROM Customer c
        JOIN Orders o ON c.Customer_ID = o.Customer_ID
        JOIN Invoice i on o.Invoice_ID = i.Invoice_ID
        JOIN Payment_Details p on i.Payment_ID = p.Payment_ID
        WHERE c.Customer_ID = @cusID
        GROUP BY c.Customer_ID, c.Customer_Username, c.First_Name, c.Last_Name;
    END
    ELSE
    BEGIN
        SELECT 'Customer Does Not Exists';
    END
END

EXEC GetTotalRevenueByCustomer 'C002';

--Procedure 7 Inactive Customer Last Order Date--

CREATE PROCEDURE GetInactiveCustomersWithLastOrderDate
    @LastOrderThreshold DATE = '2024-01-01'  -- Input parameter with a default value
AS
BEGIN
    SELECT 
        IC.Inactive_Customer_ID,
        IC.Inactive_Since,
        IC.Inactive_Reason,
        MAX(O.Order_Date) AS Last_Order_Date
    FROM Inactive_Customer IC
    LEFT JOIN Orders O ON IC.Inactive_Customer_ID = O.Customer_ID
    WHERE O.Order_Date IS NULL OR O.Order_Date < @LastOrderThreshold
    GROUP BY IC.Inactive_Customer_ID, IC.Inactive_Since, IC.Inactive_Reason;
END;

EXEC GetInactiveCustomersWithLastOrderDate @LastOrderThreshold = '2024-01-01';

--------------------------------------------------------------------------------

--View 1 Payment Details--
ALTER VIEW PaymentDetailsView 
AS
    SELECT pd.Payment_ID, pd.Payment_Date, pd.Amount, pd.Discount, pd.Payment_Method, pd.Payment_Status,
        i.Invoice_ID, c.Customer_ID, i.Invoice_Date, i.Shipping_Address,
        c.First_Name, c.Last_Name, c.Email_ID
    FROM Payment_Details pd
    JOIN Invoice i ON pd.Payment_ID = i.Payment_ID
    JOIN Customer c ON i.Customer_ID = c.Customer_ID;

SELECT * from PaymentDetailsView;

--View 2 Inactive Customer Feedback--
CREATE VIEW InactiveCustomerFeedbackView AS
SELECT
    ic.Inactive_Customer_ID,
    c.First_Name,
    c.Last_Name,
    c.Email_ID,
    c.Phone_Number,
    ic.Inactive_Since,
    f.Feedback_Date,
    f.Feedback_Type
FROM
    Inactive_Customer ic
JOIN
    Customer c ON ic.Inactive_Customer_ID = c.Customer_ID
LEFT JOIN
    Feedback f ON c.Customer_ID = f.Customer_ID;

SELECT * FROM InactiveCustomerFeedbackView

--View 3 Shipment Status--
CREATE VIEW ShipmentStatusView 
AS
SELECT s.Shipment_ID, s.Departed_Date, s.Arrival_Date, s.Shipper_Address, s.Shipment_Status, s.Shipment_Method, o.Order_ID, o.Order_Date, o.Customer_ID
FROM Shipment s
JOIN Orders o ON s.Shipment_ID = o.Shipment_ID;


select * from ShipmentStatusView;

--View 4 Supplier Product Depletion--
CREATE VIEW SupplierProductDepletionView 
AS
    SELECT s.Supplier_ID, s.Supplier_Name, dp.Product_ID, dp.Product_Depletion_Date, p.Product_Name
    FROM Supplier s
    JOIN Depleted_Product dp ON s.Supplier_ID = dp.Supplier_ID
    JOIN Product p ON dp.Product_ID = p.Product_ID;

SELECT * FROM SupplierProductDepletionView;

--View 5 Product Inventory Summary--
CREATE VIEW ProductInventorySummaryView AS
    SELECT pi.Product_ID, p.Product_Name, SUM(pi.Product_Stock_Count) AS Total_Stock_Count
    FROM Product_Inventory pi
    JOIN Product p ON pi.Product_ID = p.Product_ID
    GROUP BY pi.Product_ID, p.Product_Name;

SELECT * FROM ProductInventorySummaryView;

--View 6 Extended Order Information--

CREATE VIEW ExtendedOrderInfo AS
    SELECT O.Order_ID, O.Order_Date, O.Invoice_ID, O.Customer_ID,
        C.First_Name AS Customer_FirstName, C.Last_Name AS Customer_LastName,
        P.Product_ID, P.Product_Name,
        OL.Order_Quantity,
        S.Shipment_ID, S.Shipment_Status
    FROM Orders O
    JOIN Customer C ON O.Customer_ID = C.Customer_ID
    JOIN Order_Line OL ON O.Order_ID = OL.Order_ID
    JOIN Product P ON OL.Product_ID = P.Product_ID
    LEFT JOIN Shipment S ON O.Shipment_ID = S.Shipment_ID;

SELECT * FROM ExtendedOrderInfo;

--Trigger To Update Customer Status--

 CREATE TABLE CustomerAudit (
    [Inactive_Audit_ID] [INT] PRIMARY KEY IDENTITY(1,1),
     [Audit_Customer_ID] [VARCHAR](20) NOT NULL,
 	[Customer_Status] [varchar](20) NOT NULL,
 	[Audit_Date] [Date] NOT NULL
 );

CREATE TRIGGER Update_Customer_Status
    ON Customer
    AFTER UPDATE
AS 
BEGIN
    IF UPDATE(Customer_Status)
    BEGIN
        DECLARE @cusID VARCHAR(20);
        DECLARE @status VARCHAR(20);
        SELECT @status = Customer_Status, @cusID = Customer_ID FROM inserted;
        IF (@status = 'INACTIVE')
        BEGIN
            INSERT INTO Inactive_Customer(Inactive_Customer_ID, Inactive_Since, Inactive_Reason) 
            Values (@cusID, GETDATE(), 'No Activity Since 1 year');
            DELETE FROM Active_Customer WHERE Active_Customer_ID = @cusID;
        END
        ELSE
        BEGIN
            DECLARE @value FLOAT(2);
            SELECT @value = dbo.GetDiscountedPrice(p.Amount, p.Discount) FROM Invoice i
            JOIN Payment_Details p ON i.Payment_ID = p.Payment_ID
            JOIN Customer c ON i.Customer_ID = c.Customer_ID
            WHERE c.Customer_ID = @cusID
            ORDER BY i.Invoice_Date DESC;
            INSERT INTO Active_Customer(Active_Customer_ID, Last_Order_Value) 
            VALUES (@cusID, @value);
            DELETE FROM Inactive_Customer WHERE Inactive_Customer_ID = @cusID;
        END
        INSERT INTO CustomerAudit (Audit_Customer_ID, Customer_Status, Audit_Date)
        VALUES (@cusID, @status, GETDATE());
    END
END

--User Defined Function-- 

CREATE FUNCTION GetDiscountedPrice(
    @amount FLOAT,
    @discount FLOAT
)
RETURNS FLOAT
AS
BEGIN
    DECLARE @discountedPrice FLOAT;
    
    SET @discountedPrice = @amount - @discount;

    RETURN @discountedPrice;
END

--Non Clustered Index--

CREATE NONCLUSTERED INDEX IX_CustomerFirstName_LastName
	ON Customer (First_Name, Last_Name);

CREATE NONCLUSTERED INDEX IX_PaymentAmt_Dis
	ON Payment_Details (Payment_ID, Amount);


CREATE NONCLUSTERED INDEX IX_PaymentAmt_Dis
	ON Category (Category_ID, Category_Name);


CREATE NONCLUSTERED INDEX IX_InventoryID_Category
	ON Inventory (Inventory_ID, Inventory_Category);


CREATE NONCLUSTERED INDEX IX_SupplierName_EmailID
	ON Supplier (Supplier_Name, Email_ID);


CREATE NONCLUSTERED INDEX IX_ProductName_Price
	ON Product (Product_Name, Product_Price);