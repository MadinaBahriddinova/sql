SELECT 
    od.OrderID,
    p.ProductName,
    od.Price
FROM 
    OrderDetails od
JOIN 
    Products p ON od.ProductID = p.ProductID
WHERE 
    od.Price = (
        SELECT MAX(Price)
        FROM OrderDetails
        WHERE OrderID = od.OrderID
    );
