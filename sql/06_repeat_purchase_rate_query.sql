WITH customer_order_summary AS (
    -- CTE: Calculates the first purchase date and total number of orders for each customer
    SELECT
        customer_id,
        MIN(order_date) AS first_purchase_date, -- Finds the earliest order date for each unique customer
        COUNT(order_id) AS total_orders -- Counts the total number of orders placed by each customer
    FROM
        workspace.default.ecom_orders -- Specifies the source table containing all order data 
    GROUP BY
        customer_id -- Groups results by customer to aggregate their first purchase date and total orders
)
SELECT
    DATE_TRUNC('month', first_purchase_date) AS cohort_month, -- Truncates the first purchase date to the beginning of the month to define the customer's cohort
    -- Calculate the total number of unique customers in each cohort
    COUNT(DISTINCT customer_id) AS total_customers_in_cohort,

    -- Calculate the number of customers with at least 2, 3, or 4 orders
    SUM(CASE WHEN total_orders >= 2 THEN 1 ELSE 0 END) AS customers_2nd_order_plus, -- Counts customers who made 2 or more orders
    SUM(CASE WHEN total_orders >= 3 THEN 1 ELSE 0 END) AS customers_3rd_order_plus, -- Counts customers who made 3 or more orders
    SUM(CASE WHEN total_orders >= 4 THEN 1 ELSE 0 END) AS customers_4th_order_plus, -- Counts customers who made 4 or more orders

    -- Calculate the percentage of customers who placed at least a 2nd, 3rd, and 4th order
    -- Ensures casting to DOUBLE for accurate floating-point division to get percentages
    CAST(SUM(CASE WHEN total_orders >= 2 THEN 1 ELSE 0 END) AS DOUBLE) / COUNT(DISTINCT customer_id) * 100 AS repeat_rate_2nd_order,
    CAST(SUM(CASE WHEN total_orders >= 3 THEN 1 ELSE 0 END) AS DOUBLE) / COUNT(DISTINCT customer_id) * 100 AS repeat_rate_3rd_order,
    CAST(SUM(CASE WHEN total_orders >= 4 THEN 1 ELSE 0 END) AS DOUBLE) / COUNT(DISTINCT customer_id) * 100 AS repeat_rate_4th_order
FROM
    customer_order_summary
GROUP BY
    cohort_month -- Groups the final results by cohort month
ORDER BY
    cohort_month; -- Orders the results chronologically by cohort month