%sql
SELECT
    customer_id, -- Selects the unique customer identifier
    MIN(order_date) AS first_purchase_date -- Calculates the earliest order date for each customer, aliased as 'first_purchase_date'
FROM
    workspace.default.ecom_orders -- Specifies the source table for e-commerce orders
GROUP BY
    customer_id; -- Groups the results by customer ID to find the minimum order date for each distinct customer