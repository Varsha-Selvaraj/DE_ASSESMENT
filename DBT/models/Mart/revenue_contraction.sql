 
{{ config(
    tags=['mart', 'revenue_contraction']
) }}

WITH cte_prev_revenue AS (
    SELECT
        date_trunc('MONTH', payment_date) pay_month,
        sum(revenue*quantity) AS revenue_month,
        lag(revenue_month,3) over (order by pay_month) as revenue_lag
    FROM 
        {{ ref('stg_transactions') }}
    GROUP BY
         pay_month
),
cte_handle_null AS (
    SELECT
        pay_month, 
        revenue_month, 
        coalesce(revenue_lag, 0) AS revenue_lag 
    FROM 
        cte_prev_revenue
),
cte_revenue_loss AS(
    SELECT
        pay_month,
        revenue_month,
        revenue_lag,
        (revenue_month - revenue_lag) as revenue_loss
    FROM 
        cte_handle_null
    WHERE 
        revenue_lag > revenue_month

)
SELECT * FROM cte_revenue_loss order by pay_month

 