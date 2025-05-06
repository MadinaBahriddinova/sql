-- Step 1: Declare a table variable
DECLARE @MissingOrders TABLE (
    OrderID INT,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
);

-- Step 2: Insert orders present in DB1 but not in DB2
INSERT INTO @MissingOrders (OrderID, CustomerName, Product, Quantity)
SELECT o1.OrderID, o1.CustomerName, o1.Product, o1.Quantity
FROM Orders_DB1 o1
LEFT JOIN Orders_DB2 o2 ON o1.OrderID = o2.OrderID
WHERE o2.OrderID IS NULL;

-- Step 3: Retrieve the missing orders
SELECT * FROM @MissingOrders;
