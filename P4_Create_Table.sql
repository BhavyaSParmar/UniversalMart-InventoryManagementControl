CREATE TABLE Customer (
    Customer_ID VARCHAR(20) NOT NULL,
    CONSTRAINT Customer_ID_PK PRIMARY KEY(Customer_ID),
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Email_ID VARCHAR(50) NOT NULL,
    Phone_Number BIGINT NOT NULL,
    Customer_Street VARCHAR(50) NOT NULL,
    Customer_City VARCHAR(50) NOT NULL,
    Customer_State VARCHAR(2) NOT NULL,
    Customer_Status VARCHAR(20) NOT NULL,
    CONSTRAINT Customer_Status_CHK CHECK (Customer_Status IN ('Active','Inactive')),
    Join_Date DATE NOT NULL
);

CREATE TABLE Active_Customer (
    Active_Customer_ID VARCHAR(20) NOT NULL,
    CONSTRAINT Active_Customer_ID_PK PRIMARY KEY(Active_Customer_ID),
    CONSTRAINT Active_Customer_ID_FK FOREIGN KEY (Active_Customer_ID) REFERENCES Customer(Customer_ID),
    Last_Order_Value FLOAT
);

CREATE TABLE Inactive_Customer (
    Inactive_Customer_ID VARCHAR(20) NOT NULL,
    CONSTRAINT Inactive_Customer_ID_PK PRIMARY KEY(Inactive_Customer_ID),
    CONSTRAINT Inactive_Customer_ID_FK FOREIGN KEY (Inactive_Customer_ID) REFERENCES Customer(Customer_ID),
    Inactive_Since DATE NOT NULL,
    Inactive_Reason VARCHAR(100) NOT NULL
);


CREATE TABLE Payment_Details (
    Payment_ID VARCHAR(20) NOT NULL
    CONSTRAINT Payment_ID_PK PRIMARY KEY(Payment_ID),
    Payment_Date DATE NOT NULL,
    Amount FLOAT NOT NULL,
    Discount FLOAT NOT NULL,
    Payment_Method VARCHAR(20) NOT NULL
    CONSTRAINT Payment_Method_CHK CHECK (Payment_Method IN ('Debit Card','Credit Card','Cheque')),
    Payment_Status VARCHAR(20) NOT NULL
    CONSTRAINT Payment_Status_CHK CHECK (Payment_Status IN ('Successful','Fail'))
);

CREATE TABLE Invoice (
    Invoice_ID VARCHAR(20) NOT NULL,
    CONSTRAINT Invoice_ID_PK PRIMARY KEY(Invoice_ID),
    Customer_ID VARCHAR(20) NOT NULL
    CONSTRAINT Invoice_Customer_ID_FK FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    Invoice_Date DATE NOT NULL,
    Shipping_Address VARCHAR(100) NOT NULL,
    Payment_ID VARCHAR(20) NOT NULL
    CONSTRAINT Invoice_Payment_ID_FK FOREIGN KEY (Payment_ID) REFERENCES Payment_Details(Payment_ID),
    Invoice_Due_Date DATE NOT NULL
);

CREATE TABLE Shipment (
    Shipment_ID VARCHAR(20) NOT NULL,
    CONSTRAINT Shipment_ID_PK PRIMARY KEY(Shipment_ID),
    Departed_Date DATE NOT NULL,
    Arrival_Date DATE NOT NULL,
    Shipper_Address VARCHAR(100) NOT NULL,
    Shipment_Status VARCHAR(100) NOT NULL,
    CONSTRAINT Shipment_Status_CHK CHECK (Shipment_Status IN ('Processing','Delivered','In-Transit','Out For Delivery','Delayed')),
    Shipment_Method VARCHAR(100) NOT NULL
);

CREATE TABLE Orders (
    Order_ID VARCHAR(20) NOT NULL,
    CONSTRAINT Order_ID_PK PRIMARY KEY(Order_ID),
    Order_Date DATE NOT NULL,
    Invoice_ID VARCHAR(20) NOT NULL,
    CONSTRAINT Order_Invoice_ID_FK FOREIGN KEY (Invoice_ID) REFERENCES Invoice(Invoice_ID),
    Customer_ID VARCHAR(20) NOT NULL,
    CONSTRAINT Order_Customer_ID_FK FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    Shipment_ID VARCHAR(20) NOT NULL
    CONSTRAINT Order_Shipment_ID_FK FOREIGN KEY (Shipment_ID) REFERENCES Shipment(Shipment_ID)
);

CREATE TABLE Category
(
    Category_ID VARCHAR(20) NOT NULL,
    CONSTRAINT Category_ID_PK PRIMARY KEY(Category_ID),
    Category_Name VARCHAR(100) NOT NULL
);


CREATE TABLE Inventory
(
    Inventory_ID VARCHAR(20) NOT NULL,
    CONSTRAINT Inventory_ID_PK PRIMARY KEY(Inventory_ID),
    Inventory_Category VARCHAR(100) NOT NULL
);

CREATE TABLE Supplier
(
    Supplier_ID VARCHAR(20) NOT NULL,
    CONSTRAINT Supplier_ID_PK PRIMARY KEY(Supplier_ID),
    Supplier_Name VARCHAR(100) NOT NULL,
    Email_ID VARCHAR(100) NOT NULL,
    Phone_Number BIGINT NOT NULL,
    Supplier_Address VARCHAR(100) NOT NULL
);


CREATE TABLE Product (
    Product_ID VARCHAR(20) NOT NULL,
    CONSTRAINT Product_ID_PK PRIMARY KEY(Product_ID),
    Product_Name VARCHAR(100) NOT NULL,
    Category_ID VARCHAR(20) NOT NULL,
    CONSTRAINT Product_Category_ID_FK FOREIGN KEY (Category_ID) REFERENCES Category(Category_ID),
	Product_Price FLOAT NOT NULL,
	Product_Description VARCHAR(100) NOT NULL
);


CREATE TABLE Feedback (
    Order_ID VARCHAR(20) NOT NULL,
	CONSTRAINT Feedback_Order_ID_FK FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
	Customer_ID VARCHAR(20) NOT NULL,
	CONSTRAINT Feedback_Customer_ID_FK FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
	CONSTRAINT Feedback_PK PRIMARY KEY(Order_ID,Customer_ID),
    Feedback_Date DATE NOT NULL,
    Feedback_Type VARCHAR(20) NOT NULL
);

CREATE TABLE Order_Line (
    Order_ID VARCHAR(20) NOT NULL,
	CONSTRAINT OL_Order_ID_FK FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
	Product_ID VARCHAR(20) NOT NULL,
	CONSTRAINT OL_Product_ID_FK FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
	CONSTRAINT OL_PK PRIMARY KEY(Order_ID,Product_ID),
    Order_Quantity INT NOT NULL
);

CREATE TABLE Product_Inventory (
    Inventory_ID VARCHAR(20) NOT NULL,
	CONSTRAINT PI_Inventory_ID_FK FOREIGN KEY (Inventory_ID) REFERENCES Inventory(Inventory_ID),
	Product_ID VARCHAR(20) NOT NULL,
	CONSTRAINT PI_Product_ID_FK FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
	CONSTRAINT PI_PK PRIMARY KEY(Inventory_ID,Product_ID),
    Product_Location VARCHAR(100) NOT NULL,
	Product_Stock_Count BIGINT NOT NULL,
	Product_Received_Date DATE NOT NULL
);

CREATE TABLE Depleted_Product (
    Supplier_ID VARCHAR(20) NOT NULL,
	CONSTRAINT DP_Supplier_ID_FK FOREIGN KEY (Supplier_ID) REFERENCES Supplier(Supplier_ID),
	Product_ID VARCHAR(20) NOT NULL,
	CONSTRAINT DP_Product_ID_FK FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
	CONSTRAINT DP_PK PRIMARY KEY(Supplier_ID,Product_ID),
	Product_Depletion_Date DATE NOT NULL
);
