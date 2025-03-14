

-- WITH first_last_purchase AS (
--     SELECT
--         customer_id,
--         MIN(payment_date) AS first_purchase_date,
--         MAX(payment_date) AS last_purchase_date
--     FROM HEALTHCARE.stage.stg_transactions  AS t
--     GROUP BY customer_id
-- ),
-- max_min_overall AS(
--     SELECT
--         MAX(payment_date) AS max_date,
--         MIN(payment_date) AS min_date
--     FROM HEALTHCARE.stage.stg_transactions
-- ),
-- customer_status AS (
--     SELECT
--         flp.customer_id,
--         flp.first_purchase_date,
--         flp.last_purchase_date, 
--         CASE
--             WHEN flp.last_purchase_date < DATEADD(month, -3, mmo.max_date) THEN 1
--             ELSE 0
--         END AS churned_customer,
--         CASE
--             WHEN flp.first_purchase_date > DATEADD(month, -3, mmo.max_date) THEN 1
--             ELSE 0
--         END AS new_customer
--     FROM first_last_purchase AS flp
--     CROSS JOIN max_min_overall AS mmo
-- ),
-- customer_status_over_time AS (
--     SELECT
--         DATE_TRUNC('month', flp.first_purchase_date) AS month,
--         SUM(cs.churned_customer) AS churned_customers,
--         SUM(cs.new_customer) AS new_customers
--     FROM customer_status AS cs
--     JOIN first_last_purchase AS flp ON cs.customer_id = flp.customer_id
--     GROUP BY month
-- )
-- SELECT 
--     month,
--     churned_customers,
--     new_customers
-- FROM 
--     customer_status_over_time
-- ORDER BY 
--     month

WITH transactions AS (
    SELECT DISTINCT CUSTOMER_ID, payment_date
    FROM HEALTHCARE.stage.stg_transactions
),

customer_lifetime AS (
    SELECT 
        CUSTOMER_ID, 
        MIN(payment_date) AS first_purchase_month, 
        MAX(payment_date) AS last_purchase_month
    FROM transactions
    GROUP BY CUSTOMER_ID
),

churn_analysis AS (
    SELECT 
        payment_date,
        COUNT(DISTINCT CASE WHEN first_purchase_month = payment_date THEN CUSTOMER_ID END) AS new_customers,
        COUNT(DISTINCT CASE WHEN last_purchase_month = payment_date THEN CUSTOMER_ID END) AS churned_customers
    FROM transactions
    JOIN customer_lifetime USING (CUSTOMER_ID)
    GROUP BY payment_date
)

SELECT * FROM churn_analysis