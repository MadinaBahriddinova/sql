SELECT 
    o.OrderID, 
    p.ProductName, 
    od.Quantity
FROM 
    Orders o
JOIN 
    OrderDetails od ON o.OrderID = od.OrderID
JOIN 
    Products p ON od.ProductID = p.ProductID;
