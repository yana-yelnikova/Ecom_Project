%sql
SELECT
    e.customer_id,
    MIN(e.order_date) AS second_purchase_date -- Selects the customer ID and calculates the minimum order date as the second purchase date
FROM
    workspace.default.ecom_orders AS e -- Specifies the source table for order data, aliased as 'e'
JOIN
    _sqldf AS fp ON e.customer_id = fp.customer_id -- Joins with '_sqldf' (assumed to contain first purchase dates from a previous cell), aliased as 'fp', using customer_id
WHERE
    e.order_date > fp.first_purchase_date -- Filters orders to include only those that occurred strictly after the first purchase date
GROUP BY
    e.customer_id; -- Groups the results by customer_id to ensure a single second purchase date per customer