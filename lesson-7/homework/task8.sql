SELECT DISTINCT 
    c.CustomerID, 
    c.CustomerName
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID
JOIN 
    OrderDetails od ON o.OrderID = od.OrderID
JOIN 
    Products p ON od.ProductID = p.ProductID
WHERE 
    p.Category = 'Stationery';
