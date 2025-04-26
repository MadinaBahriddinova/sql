SELECT 
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
GROUP BY 
    c.CustomerID, c.CustomerName
HAVING 
    COUNT(DISTINCT CASE WHEN p.Category <> 'Electronics' THEN p.Category END) = 0;
