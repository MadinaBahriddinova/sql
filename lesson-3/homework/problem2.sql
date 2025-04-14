DROP TABLE IF EXISTS  Employees
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE
);
DROP TABLE IF EXISTS Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'))
);
DROP TABLE IF EXISTS Products
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);
SELECT
    CASE 
        WHEN Status IN ('Shipped', 'Delivered') THEN 'Completed'
        WHEN Status = 'Pending' THEN 'Pending'
        WHEN Status = 'Cancelled' THEN 'Cancelled'
    END AS OrderStatus,
    COUNT(*) AS TotalOrders,
    SUM(TotalAmount) AS TotalRevenue
FROM Orders
WHERE OrderDate BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY 
    CASE 
        WHEN Status IN ('Shipped', 'Delivered') THEN 'Completed'
        WHEN Status = 'Pending' THEN 'Pending'
        WHEN Status = 'Cancelled' THEN 'Cancelled'
    END
HAVING SUM(TotalAmount) > 5000
ORDER BY TotalRevenue DESC;


