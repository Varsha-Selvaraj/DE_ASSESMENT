

WITH cte_new_logos as (
    SELECT 
        customer_id, 
        MIN(payment_date) AS first_purchase_date,
        EXTRACT(YEAR FROM MIN(payment_date)) AS fiscal_year
    FROM 
        HEALTHCARE.stage.stg_transactions
    GROUP BY 
        customer_id
)

SELECT 
    fiscal_year, 
    COUNT(DISTINCT customer_id) AS new_customers
FROM 
    cte_new_logos 
GROUP BY 
    fiscal_year