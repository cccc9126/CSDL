USE ecommerce_db;

INSERT INTO orders VALUES
(25, 18, '2025-05-01', 700000),
(26, 18, '2025-05-03', 1300000),
(27, 19, '2025-05-05', 500000),
(28, 20, '2025-05-07', 900000),
(29, 21, '2025-05-09', 400000);

SELECT customer_id
FROM orders
GROUP BY customer_id
HAVING SUM(total_amount) > (
    SELECT AVG(total_spent)
    FROM (
        SELECT SUM(total_amount) AS total_spent
        FROM orders
        GROUP BY customer_id
    ) AS temp
);
