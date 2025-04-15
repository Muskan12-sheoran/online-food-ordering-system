CREATE DATABASE SAM;
USE SAM;
CREATE TABLE CUSTOMER(
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    Address TEXT,
    Username VARCHAR(50)
);

INSERT INTO Customer VALUES
(1, 'John Doe', 'john@example.com', '9876543210', '123 Main Street', 'john_d'),
(2, 'Alice Smith', 'alice@example.com', '9876500000', '456 Park Avenue', 'alice_s'),
(3, 'Ravi Kumar', 'ravi@example.com', '9876512345', 'MG Road', 'ravi_k'),
(4, 'Neha Sharma', 'neha@example.com', '9876522222', 'BTM Layout', 'neha_s'),
(5, 'Imran Ali', 'imran@example.com', '9876533333', 'Indiranagar', 'imran_a'),
(6, 'Sneha Patel', 'sneha@example.com', '9876544444', 'JP Nagar', 'sneha_p'),
(7, 'Amit Roy', 'amit@example.com', '9876555555', 'Whitefield', 'amit_r'),
(8, 'Tina Mehta', 'tina@example.com', '9876566666', 'Banashankari', 'tina_m');
CREATE TABLE Restaurant (
    RestaurantID INT PRIMARY KEY,
    Name VARCHAR(100),
    Address TEXT,
    Contact VARCHAR(15),
    CuisineType VARCHAR(50)
);

INSERT INTO Restaurant VALUES
(1, 'Spicy Bites', 'Market Road', '9000112233', 'Indian'),
(2, 'Pizza Town', 'King Street', '9000223344', 'Italian'),
(3, 'Burger Zone', 'MG Road', '9000334455', 'Fast Food'),
(4, 'Tandoori Hub', 'BTM Layout', '9000445566', 'North Indian'),
(5, 'Green Bowl', 'JP Nagar', '9000556677', 'Healthy'),
(6, 'Curry Palace', 'Indiranagar', '9000667788', 'South Indian'),
(7, 'Chopsticks', 'Whitefield', '9000778899', 'Chinese'),
(8, 'Sweet Treats', 'Banashankari', '9000889900', 'Desserts');
CREATE TABLE MenuItem (
    ItemID INT PRIMARY KEY,
    Name VARCHAR(100),
    Price DECIMAL(10, 2),
    RestaurantID INT,
    Category VARCHAR(50),
    FOREIGN KEY (RestaurantID) REFERENCES Restaurant(RestaurantID)
);

INSERT INTO MenuItem VALUES
(1, 'Chicken Burger', 120.00, 3, 'Burger'),
(2, 'Veg Pizza', 150.00, 2, 'Pizza'),
(3, 'Coke', 50.00, 2, 'Drink'),
(4, 'Paneer Tikka', 180.00, 1, 'Starter'),
(5, 'Momos', 90.00, 7, 'Snacks'),
(6, 'Gulab Jamun', 60.00, 8, 'Dessert'),
(7, 'Masala Dosa', 80.00, 6, 'Breakfast'),
(8, 'Green Salad', 70.00, 5, 'Healthy');
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    Status VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

INSERT INTO Orders VALUES
(101, 1, '2025-04-12', 270.00, 'Pending'),
(102, 2, '2025-04-11', 150.00, 'Delivered'),
(103, 3, '2025-04-10', 120.00, 'Delivered'),
(104, 4, '2025-04-09', 90.00, 'Preparing'),
(105, 5, '2025-04-08', 80.00, 'Cancelled'),
(106, 6, '2025-04-07', 200.00, 'Delivered'),
(107, 7, '2025-04-06', 60.00, 'Pending'),
(108, 8, '2025-04-05', 70.00, 'Delivered');
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ItemID INT,
    Quantity INT,
    ItemPrice DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ItemID) REFERENCES MenuItem(ItemID)
);

INSERT INTO OrderDetails VALUES
(1, 101, 1, 2, 240.00), -- 2 Chicken Burgers
(2, 101, 3, 1, 50.00),  -- 1 Coke
(3, 102, 2, 1, 150.00), -- 1 Veg Pizza
(4, 103, 1, 1, 120.00), -- 1 Chicken Burger
(5, 104, 5, 2, 180.00), -- 2 Momos
(6, 105, 7, 1, 80.00),  -- 1 Masala Dosa
(7, 106, 4, 1, 180.00), -- 1 Paneer Tikka
(8, 107, 6, 1, 60.00);  -- 1 Gulab Jamun
CREATE TABLE Delivery1(
    DeliveryID INT PRIMARY KEY,
    OrderID INT UNIQUE,
    DeliveryStatus VARCHAR(20),
    DeliveryTime TIME,
    AgentName VARCHAR(100),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO DeliveryVALUES
(1, 101, 'Out for Delivery', '19:00:00', 'Ravi Kumar'),
(2, 102, 'Delivered', '17:30:00', 'Neha Singh'),
(3, 103, 'Delivered', '18:15:00', 'Imran Ali'),
(4, 104, 'Preparing', NULL, 'Sneha Patel'),
(5, 105, 'Cancelled', NULL, NULL),
(6, 106, 'Delivered', '16:45:00', 'Amit Roy'),
(7, 107, 'Out for Delivery', '20:00:00', 'Tina Mehta'),
(8, 108, 'Delivered', '15:30:00', 'Rahul Joshi');
select*from CUSTOMER;
SELECT Name AS R_Name, Address AS Address_Name
FROM Restaurant;
SELECT COUNT(*) AS totalOrderDelivery
FROM Delivery
WHERE DeliveryStatus = 'Delivered';
SELECT d.OrderID, d.DeliveryStatus, d.AgentName, c.Name AS CustomerName
FROM Delivery d
JOIN Orders o ON d.OrderID = o.OrderID
JOIN Customer c ON o.CustomerID = c.CustomerID;
select*from orders
where totalamount<100;
UPDATE Delivery
SET DeliveryStatus = 'Cancelled'
WHERE OrderID = 103;
SELECT * 
FROM MenuItem
WHERE Price > 100;
SELECT c.Name, SUM(o.TotalAmount) AS TotalSpent
FROM Customer c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.Name;
SELECT r.Name AS RestaurantName, COUNT(*) AS TotalOrders
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN MenuItem mi ON od.ItemID = mi.ItemID
JOIN Restaurant r ON mi.RestaurantID = r.RestaurantID
GROUP BY r.Name;
SELECT mi.Name, SUM(od.Quantity) AS TotalOrdered
FROM OrderDetails od
JOIN MenuItem mi ON od.ItemID = mi.ItemID
GROUP BY mi.Name
ORDER BY TotalOrdered DESC
LIMIT 1;