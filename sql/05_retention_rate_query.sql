
WITH FirstPurchases AS (
    -- CTE 1: Calculates the first purchase date for each customer
    SELECT
        customer_id,
        MIN(order_date) AS first_purchase_date -- Finds the earliest order date for each unique customer
    FROM
        workspace.default.ecom_orders -- Specifies the source table containing all order data
    GROUP BY
        customer_id -- Groups results by customer to ensure one first purchase date per customer
),
SecondPurchases AS (
    -- CTE 2: Calculates the second purchase date for each customer
    SELECT
        e.customer_id,
        MIN(e.order_date) AS second_purchase_date -- Finds the earliest order date that qualifies as a second purchase
    FROM
        workspace.default.ecom_orders AS e -- Aliases the original orders table as 'e'
    JOIN
        FirstPurchases AS fp ON e.customer_id = fp.customer_id -- Joins with FirstPurchases CTE to get each customer's first purchase date
    WHERE
        e.order_date > fp.first_purchase_date -- Filters orders to include only those strictly after the first purchase
    GROUP BY
        e.customer_id -- Groups by customer to get the single earliest date after the first purchase
),
CustomerPurchaseDates AS (
    -- CTE 3: Combines first and second purchase dates for all customers
    SELECT
        fp.customer_id,
        fp.first_purchase_date,
        sp.second_purchase_date -- Will be NULL for customers with only one purchase
    FROM
        FirstPurchases AS fp
    LEFT JOIN
        SecondPurchases AS sp ON fp.customer_id = sp.customer_id -- LEFT JOIN ensures all customers from FirstPurchases are included
),
CustomersWithCohortAndMonthDiff AS (
    -- CTE 4: Assigns a cohort month and calculates the month difference to the second purchase
    SELECT
        DATE_TRUNC('month', cpd.first_purchase_date) AS cohort_month, -- Truncates the first purchase date to the beginning of the month to define the customer's cohort
        cpd.customer_id,
        cpd.first_purchase_date,
        cpd.second_purchase_date,
        CASE
            WHEN cpd.second_purchase_date IS NOT NULL THEN
                -- Calculates the difference in months between the first and second purchase.
                -- DATEDIFF returns days, so we divide by average days in a month (30.4) and cast to INT.
                CAST(DATEDIFF(cpd.second_purchase_date, cpd.first_purchase_date) / 30.4 AS INT)
            ELSE NULL
        END AS months_to_second_purchase
    FROM
        CustomerPurchaseDates AS cpd
)
-- Final SELECT: Calculates retention rates for each cohort
SELECT
    c.cohort_month,
    COUNT(DISTINCT c.customer_id) AS total_cohort_customers, -- Counts the total unique customers in each cohort
    -- Calculates the percentage of customers retained within 1 month
    ROUND(COUNT(DISTINCT CASE WHEN c.months_to_second_purchase <= 1 THEN c.customer_id ELSE NULL END) * 100.0 / COUNT(DISTINCT c.customer_id), 2) AS retention_1_month_pct,
    -- Calculates the percentage of customers retained within 2 months
    ROUND(COUNT(DISTINCT CASE WHEN c.months_to_second_purchase <= 2 THEN c.customer_id ELSE NULL END) * 100.0 / COUNT(DISTINCT c.customer_id), 2) AS retention_2_month_pct,
    -- Calculates the percentage of customers retained within 3 months
    ROUND(COUNT(DISTINCT CASE WHEN c.months_to_second_purchase <= 3 THEN c.customer_id ELSE NULL END) * 100.0 / COUNT(DISTINCT c.customer_id), 2) AS retention_3_month_pct
FROM
    CustomersWithCohortAndMonthDiff AS c
GROUP BY
    c.cohort_month -- Groups the final results by cohort month
ORDER BY
    c.cohort_month; -- Orders the results chronologically by cohort month