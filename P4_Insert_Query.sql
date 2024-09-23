INSERT INTO Customer (Customer_ID, First_Name, Last_Name, Email_ID, Phone_Number, Customer_Street, Customer_City, Customer_State, Customer_Status, Join_Date)
VALUES
('C001', 'John', 'Doe', 'john.doe@email.com', 1234567890, '123 Main St', 'Cityville', 'CA', 'Active', '2022-01-01'),
('C002', 'Jane', 'Smith', 'jane.smith@email.com', 9876543210, '456 Oak St', 'Townsville', 'NY', 'Inactive', '2022-12-15'),
('C003', 'Alice', 'Johnson', 'alice.johnson@email.com', 5551234567, '789 Pine St', 'Villagetown', 'TX', 'Active', '2022-02-20'),
('C004', 'Bob', 'Williams', 'bob.williams@email.com', 7778889999, '101 Elm St', 'Hamletville', 'FL', 'Active', '2022-03-10'),
('C005', 'Eva', 'Anderson', 'eva.anderson@email.com', 3334445555, '202 Cedar St', 'Cityburg', 'IL', 'Inactive', '2022-11-05'),
('C006', 'David', 'Brown', 'david.brown@email.com', 1112223333, '303 Birch St', 'Villageburg', 'OH', 'Active', '2022-04-25'),
('C007', 'Sophia', 'Lee', 'sophia.lee@email.com', 9990001111, '404 Maple St', 'Towndale', 'PA', 'Inactive', '2022-10-12'),
('C008', 'Michael', 'Garcia', 'michael.garcia@email.com', 6667778888, '505 Walnut St', 'Citydale', 'GA', 'Active', '2022-05-15'),
('C009', 'Olivia', 'Martin', 'olivia.martin@email.com', 4445556666, '606 Pine St', 'Villageville', 'NC', 'Active', '2022-06-30'),
('C010', 'William', 'Taylor', 'william.taylor@email.com', 2223334444, '707 Oak St', 'Townburg', 'MI', 'Inactive', '2022-09-08');

INSERT INTO Active_Customer (Active_Customer_ID, Last_Order_Value)
VALUES
('C001', 4799.25),
('C003', 9500),
('C004', 11400.75),
('C006', 5749.25),
('C008', 9249.80),
('C009', 7700.80);

INSERT INTO Inactive_Customer (Inactive_Customer_ID, Inactive_Since, Inactive_Reason)
VALUES
('C002', '2023-11-30', 'Account closure'),
('C005', '2023-10-15', 'No activity for 6 months'),
('C007', '2023-09-20', 'Customer request'),
('C010', '2023-08-01', 'Relocation');

INSERT INTO Payment_Details (Payment_ID, Payment_Date, Amount, Discount, Payment_Method, Payment_Status)
VALUES
('P001', '2023-01-10', 5000.00, 200.50, 'Credit Card', 'Successful'),
('P002', '2023-02-15', 7500.20, 300.75, 'Debit Card', 'Successful'),
('P003', '2023-03-20', 10000.50, 500.00, 'Cheque', 'Successful'),
('P004', '2023-04-25', 12000.00, 600.25, 'Credit Card', 'Successful'),
('P005', '2023-05-30', 8500.00, 400.00, 'Debit Card', 'Fail'),
('P006', '2023-06-05', 6000.00, 250.75, 'Cheque', 'Successful'),
('P007', '2023-07-10', 11000.45, 450.80, 'Credit Card', 'Fail'),
('P008', '2023-08-15', 9500.00, 350.20, 'Debit Card', 'Successful'),
('P009', '2023-09-20', 8000.80, 300.00, 'Cheque', 'Successful'),
('P010', '2023-10-25', 7000.20, 200.45, 'Credit Card', 'Fail');

INSERT INTO Shipment (Shipment_ID, Departed_Date, Arrival_Date, Shipper_Address, Shipment_Status, Shipment_Method)
VALUES
('S001', '2023-01-05', '2023-01-15', '123 Shipping Lane, Cityville, CA', 'Processing', 'Air Freight'),
('S002', '2023-02-10', '2023-02-20', '456 Cargo Street, Townsville, NY', 'Delivered', 'Ground Shipping'),
('S003', '2023-03-15', '2023-03-25', '789 Logistics Avenue, Villagetown, TX', 'In-Transit', 'Ocean Freight'),
('S004', '2023-04-20', '2023-05-01', '101 Express Road, Hamletville, FL', 'Out For Delivery', 'Ground Shipping'),
('S005', '2023-05-25', '2023-06-05', '202 Dispatch Lane, Cityburg, IL', 'Delayed', 'Air Freight'),
('S006', '2023-06-01', '2023-06-10', '303 Transit Street, Villageburg, OH', 'Processing', 'Ground Shipping'),
('S007', '2023-07-05', '2023-07-15', '404 Transport Road, Towndale, PA', 'In-Transit', 'Ocean Freight'),
('S008', '2023-08-10', '2023-08-20', '505 Shipment Lane, Citydale, GA', 'Out For Delivery', 'Ground Shipping'),
('S009', '2023-09-15', '2023-09-25', '606 Express Avenue, Villageville, NC', 'Processing', 'Air Freight'),
('S010', '2023-10-20', '2023-10-30', '707 Delivery Street, Townburg, MI', 'Delivered', 'Ground Shipping');


INSERT INTO Invoice (Invoice_ID, Customer_ID, Invoice_Date, Shipping_Address, Payment_ID, Invoice_Due_Date)
VALUES
('INV001', 'C001', '2023-01-10', '123 Main St, Cityville, CA', 'P001', '2023-01-20'),
('INV002', 'C002', '2023-02-15', '456 Oak St, Townsville, NY', 'P002', '2023-02-25'),
('INV003', 'C003', '2023-03-20', '789 Pine St, Villagetown, TX', 'P003', '2023-03-30'),
('INV004', 'C004', '2023-04-25', '101 Elm St, Hamletville, FL', 'P004', '2023-05-05'),
('INV005', 'C005', '2023-05-30', '202 Cedar St, Cityburg, IL', 'P005', '2023-06-09'),
('INV006', 'C006', '2023-06-05', '303 Birch St, Villageburg, OH', 'P006', '2023-06-15'),
('INV007', 'C007', '2023-07-10', '404 Maple St, Towndale, PA', 'P007', '2023-07-20'),
('INV008', 'C008', '2023-08-15', '505 Walnut St, Citydale, GA', 'P008', '2023-08-25'),
('INV009', 'C009', '2023-09-20', '606 Pine St, Villageville, NC', 'P009', '2023-09-30'),
('INV010', 'C010', '2023-10-25', '707 Oak St, Townburg, MI', 'P010', '2023-11-04');

INSERT INTO Orders (Order_ID, Order_Date, Invoice_ID, Customer_ID, Shipment_ID)
VALUES
('O001', '2023-01-15', 'INV001', 'C001', 'S001'),
('O002', '2023-02-20', 'INV002', 'C002', 'S002'),
('O003', '2023-03-25', 'INV003', 'C003', 'S003'),
('O004', '2023-05-01', 'INV004', 'C004', 'S004'),
('O005', '2023-06-05', 'INV005', 'C005', 'S005'),
('O006', '2023-06-10', 'INV006', 'C006', 'S006'),
('O007', '2023-07-15', 'INV007', 'C007', 'S007'),
('O008', '2023-08-20', 'INV008', 'C008', 'S008'),
('O009', '2023-09-25', 'INV009', 'C009', 'S009'),
('O010', '2023-10-30', 'INV010', 'C010', 'S010');

INSERT INTO Category (Category_ID, Category_Name)
VALUES
('C001', 'Electronics'),
('C002', 'Clothing'),
('C003', 'Home Appliances'),
('C004', 'Furniture'),
('C005', 'Books'),
('C006', 'Toys'),
('C007', 'Sporting Goods'),
('C008', 'Beauty and Personal Care'),
('C009', 'Jewelry'),
('C010', 'Office Supplies');

INSERT INTO Inventory (Inventory_ID, Inventory_Category)
VALUES
('INV001', 'Finished Goods'),
('INV002', 'Raw Materials'),
('INV003', 'Work-in-Progress'),
('INV004', 'Transit Inventory'),
('INV005', 'Obsolete Inventory'),
('INV006', 'Perishable Goods'),
('INV007', 'High-Value Items'),
('INV008', 'Electronic Components'),
('INV009', 'Promotional Materials'),
('INV010', 'Safety Stock');

INSERT INTO Supplier (Supplier_ID, Supplier_Name, Email_ID, Phone_Number, Supplier_Address)
VALUES
('S001', 'ABC Electronics', 'abc.electronics@email.com', 1234567890, '123 Tech Street, Cityville, CA'),
('S002', 'Fashion Trends Inc.', 'info@fashiontrends.com', 9876543210, '456 Style Avenue, Townsville, NY'),
('S003', 'Build-It-All Supplies', 'builditall@email.com', 5551234567, '789 Construction Lane, Villagetown, TX'),
('S004', 'Furniture World', 'info@furnitureworld.com', 7778889999, '101 Comfort Street, Hamletville, FL'),
('S005', 'Book Haven Distributors', 'books@haven.com', 3334445555, '202 Library Road, Cityburg, IL'),
('S006', 'Toys R Us Wholesale', 'toysrus@email.com', 1112223333, '303 Play Street, Villageburg, OH'),
('S007', 'Sporty Supplies Co.', 'info@sportysupplies.com', 9990001111, '404 Sports Avenue, Towndale, PA'),
('S008', 'Beauty Essentials Ltd.', 'beauty@email.com', 6667778888, '505 Glamour Lane, Citydale, GA'),
('S009', 'Gemstone Creations', 'gems@email.com', 4445556666, '606 Jewel Street, Villageville, NC'),
('S010', 'Office Depot Wholesale', 'office@email.com', 2223334444, '707 Workspace Road, Townburg, MI');

INSERT INTO Product (Product_ID, Product_Name, Category_ID, Product_Price, Product_Description)
VALUES
('P001', 'Smartphone X', 'C001', 1200.00, 'High-end smartphone with advanced features'),
('P002', 'Designer Suit', 'C002', 800.00, 'Premium quality designer suit for special occasions'),
('P003', 'Smart Refrigerator', 'C003', 1500.00, 'Refrigerator with smart technology and energy efficiency'),
('P004', 'Luxury Sofa Set', 'C004', 2500.00, 'Elegant and comfortable sofa set for your living room'),
('P005', 'Limited Edition Book Set', 'C005', 500.00, 'Exclusive collection of limited edition books'),
('P006', 'Advanced Robot Toy', 'C006', 300.00, 'Educational and interactive robot toy for kids'),
('P007', 'Professional Tennis Racket', 'C007', 200.00, 'High-quality tennis racket for professional players'),
('P008', 'Premium Skincare Kit', 'C008', 180.00, 'Luxurious skincare products for a radiant complexion'),
('P009', 'Diamond Necklace', 'C009', 3500.00, 'Exquisite diamond necklace for special occasions'),
('P010', 'Executive Desk Set', 'C010', 1200.00, 'Elegant desk set for a sophisticated office environment');

INSERT INTO Feedback (Order_ID, Customer_ID, Feedback_Date, Feedback_Type)
VALUES
('O001', 'C001', '2023-01-20', 'Positive'),
('O002', 'C002', '2023-02-25', 'Negative'),
('O003', 'C003', '2023-03-30', 'Neutral'),
('O004', 'C004', '2023-05-05', 'Positive'),
('O005', 'C005', '2023-06-09', 'Positive'),
('O006', 'C006', '2023-06-15', 'Negative'),
('O007', 'C007', '2023-07-20', 'Positive'),
('O008', 'C008', '2023-08-25', 'Neutral'),
('O009', 'C009', '2023-09-30', 'Negative'),
('O010', 'C010', '2023-11-04', 'Positive');

INSERT INTO Order_Line (Order_ID, Product_ID, Order_Quantity)
VALUES
('O001', 'P001', 4),
('O002', 'P002', 11),
('O003', 'P003', 3),
('O004', 'P004', 9),
('O005', 'P005', 8),
('O006', 'P006', 5),
('O007', 'P007', 2),
('O008', 'P008', 3),
('O009', 'P009', 7),
('O010', 'P010', 3);

INSERT INTO Product_Inventory (Inventory_ID, Product_ID, Product_Location, Product_Stock_Count, Product_Received_Date)
VALUES
('INV001', 'P001', 'Storage Room 1', 50, '2023-01-20'),
('INV002', 'P002', 'Warehouse A', 100, '2023-02-25'),
('INV003', 'P003', 'Factory Floor', 75, '2023-03-30'),
('INV004', 'P004', 'In Transit', 30, '2023-05-05'),
('INV005', 'P005', 'Warehouse B', 10, '2023-06-09'),
('INV006', 'P006', 'Cooler Room', 20, '2023-06-15'),
('INV007', 'P007', 'High-Security Vault', 5, '2023-07-20'),
('INV008', 'P008', 'Component Storage', 200, '2023-08-25'),
('INV009', 'P009', 'Promotions Section', 15, '2023-09-30'),
('INV010', 'P010', 'Safety Stock Room', 25, '2023-11-04');

INSERT INTO Depleted_Product (Supplier_ID, Product_ID, Product_Depletion_Date)
VALUES
('S001', 'P001', '2023-01-25'),
('S002', 'P002', '2023-02-28'),
('S003', 'P003', '2023-04-05'),
('S004', 'P004', '2023-05-10'),
('S005', 'P005', '2023-06-15'),
('S006', 'P006', '2023-07-20'),
('S007', 'P007', '2023-08-25'),
('S008', 'P008', '2023-09-30'),
('S009', 'P009', '2023-11-04'),
('S010', 'P010', '2023-12-10');