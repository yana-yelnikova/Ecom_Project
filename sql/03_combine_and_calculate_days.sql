%sql
SELECT
    fp.customer_id, -- Selects the customer identifier
    fp.first_purchase_date, -- Selects the first purchase date for each customer
    sp.second_purchase_date, -- Selects the second purchase date for each customer
    DATEDIFF(sp.second_purchase_date, fp.first_purchase_date) AS days_between_purchases
    -- Calculates the difference in days between the second and first purchase dates
FROM
    -- This subquery re-calculates the first purchase date.
    -- This is necessary because _sqldf will contain the result of the *last* executed query (Step 2 in this case),
    -- so we cannot rely on _sqldf for the first_purchase_date here.
    (
        SELECT
            customer_id,
            MIN(order_date) AS first_purchase_date
        FROM
            workspace.default.ecom_orders
        GROUP BY
            customer_id
    ) AS fp (customer_id, first_purchase_date) -- Aliases the subquery result as 'fp' and explicitly defines its columns
LEFT JOIN
    _sqldf AS sp ON fp.customer_id = sp.customer_id;
    -- Joins with '_sqldf' (assumed to contain the second purchase dates from Step 2), aliased as 'sp'.
    -- A LEFT JOIN ensures that all customers with a first purchase are included,
    -- even if they don't have a second purchase (in which case second_purchase_date will be NULL).