CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    price DECIMAL(10,2)
);

CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT
);

INSERT INTO products VALUES
(1, 'Laptop Dell', 20000000),
(2, 'iPhone', 15000000),
(3, 'Tai nghe Bluetooth', 1500000),
(4, 'Chuột không dây', 500000),
(5, 'Bàn phím cơ', 2000000),
(6, 'Màn hình', 6000000);

INSERT INTO order_items VALUES
(101, 1, 3),
(102, 1, 4),
(103, 1, 5),

(104, 2, 5),
(105, 2, 6),

(106, 3, 4),
(107, 3, 4),
(108, 3, 3),

(109, 4, 10),
(110, 4, 5),

(111, 5, 6),
(112, 5, 5),

(113, 6, 2),
(114, 6, 3),
(115, 6, 5);


SELECT 
    p.product_name,
    SUM(oi.quantity) AS total_quantity,
    SUM(oi.quantity * p.price) AS total_revenue,
    AVG(p.price) AS avg_price
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(oi.quantity) >= 10
ORDER BY total_revenue DESC
LIMIT 5;
