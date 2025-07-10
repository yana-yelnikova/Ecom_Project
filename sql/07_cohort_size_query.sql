WITH customer_first_purchase AS (
    -- CTE: Finds the first purchase date for each customer
    SELECT
        customer_id, -- Unique identifier for the customer
        MIN(order_date) AS first_purchase_date -- The earliest order date for each customer, defining their initial entry point
    FROM
        workspace.default.ecom_orders -- Source table containing all e-commerce order data
    GROUP BY
        customer_id -- Groups data by customer to find their first purchase date
)
SELECT
    DATE_TRUNC('month', first_purchase_date) AS cohort_month, -- Truncates the first purchase date to the beginning of the month to define the monthly cohort
    COUNT(customer_id) AS new_customers -- Counts the total number of unique customers whose first purchase falls into this cohort month
FROM
    customer_first_purchase
GROUP BY
    cohort_month -- Groups the results by the defined cohort month
ORDER BY
    cohort_month; -- Orders the results chronologically by cohort month