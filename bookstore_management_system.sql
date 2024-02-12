-- Create Authors table
CREATE TABLE Authors (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    author_name VARCHAR(100) NOT NULL
);

-- Create Books table
CREATE TABLE Books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    author_id INT,
    price DECIMAL(10, 2) NOT NULL,
    quantity_available INT NOT NULL,
    publication_year INT,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

-- Create Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(255),
    phone_number VARCHAR(20)
);

-- Create Orders table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Create Order_Items table
CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    book_id INT,
    quantity INT NOT NULL,
    price_per_unit DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- Insert sample data into Authors table
INSERT INTO Authors (author_name) VALUES
('Author 1'),
('Author 2'),
('Author 3');

-- Insert sample data into Books table
INSERT INTO Books (title, author_id, price, quantity_available, publication_year) VALUES
('Book 1', 1, 19.99, 100, 2020),
('Book 2', 2, 24.99, 150, 2018),
('Book 3', 3, 29.99, 80, 2022);

-- Insert sample data into Customers table
INSERT INTO Customers (customer_name, email, phone_number) VALUES
('Customer A', 'customerA@example.com', '1234567890'),
('Customer B', 'customerB@example.com', '9876543210'),
('Customer C', 'customerC@example.com', '5555555555');

-- Insert sample data into Orders table
INSERT INTO Orders (customer_id, order_date) VALUES
(1, '2024-01-15'),
(2, '2024-01-20'),
(3, '2024-01-25');

-- Insert sample data into Order_Items table
INSERT INTO Order_Items (order_id, book_id, quantity, price_per_unit) VALUES
(1, 1, 2, 19.99),
(1, 2, 1, 24.99),
(2, 1, 3, 19.99),
(3, 3, 2, 29.99);

-- Retrieve a list of top-selling books
SELECT b.title, a.author_name, SUM(oi.quantity) AS total_sold
FROM Books b
INNER JOIN Authors a ON b.author_id = a.author_id
INNER JOIN Order_Items oi ON b.book_id = oi.book_id
GROUP BY b.book_id
ORDER BY total_sold DESC
LIMIT 10;

-- Calculate total sales revenue for a given period (January 2024)
SELECT SUM(oi.quantity * oi.price_per_unit) AS total_revenue
FROM Orders o
INNER JOIN Order_Items oi ON o.order_id = oi.order_id
WHERE o.order_date >= '2024-01-01' AND o.order_date < '2024-02-01';
