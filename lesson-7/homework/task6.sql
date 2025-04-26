SELECT 
    o.CustomerID,
    c.CustomerName,
    o.OrderID,
    o.OrderDate
FROM 
    Orders o
JOIN 
    Customers c ON o.CustomerID = c.CustomerID
WHERE 
    o.OrderDate = (
        SELECT MAX(OrderDate)
        FROM Orders
        WHERE CustomerID = o.CustomerID
    );
