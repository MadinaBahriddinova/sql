SELECT 
    c.CustomerID,
    c.CustomerName,
    SUM(od.Quantity * od.Price) AS TotalSpent
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID
JOIN 
    OrderDetails od ON o.OrderID = od.OrderID
GROUP BY 
    c.CustomerID, c.CustomerName;
