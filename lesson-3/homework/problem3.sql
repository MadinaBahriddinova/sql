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

WITH MostExpensivePerCategory AS (
    SELECT 
        Category,
        ProductName,
        Price,
        Stock,
        IIF(Stock = 0, 'Out of Stock',
            IIF(Stock BETWEEN 1 AND 10, 'Low Stock', 'In Stock')) AS InventoryStatus,
        ROW_NUMBER() OVER (PARTITION BY Category ORDER BY Price DESC) AS rn
    FROM Products
)
SELECT Category, ProductName, Price, InventoryStatus
FROM MostExpensivePerCategory
WHERE rn = 1
ORDER BY Price DESC
OFFSET 5 ROWS;
