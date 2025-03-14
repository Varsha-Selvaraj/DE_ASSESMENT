
{{ config(
    tags=['mart', 'rank_customers_revenue']
) }}

WITH cte_customer_revenue AS (
    SELECT 
        customer_id, 
        SUM(revenue) AS total_revenue
    FROM 
        {{ ref('stg_transactions') }}
    GROUP BY 
        customer_id
)

SELECT 
    cr.customer_id, 
    c.customer_name, 
    cr.total_revenue, 
    crg.country,
    crg.region,
    RANK() OVER (ORDER BY cr.total_revenue DESC) as revenue_rank
    
FROM 
    cte_customer_revenue cr
JOIN   
    {{ ref('stg_customers') }} c
ON 
    cr.customer_id = c.customer_id
LEFT JOIN 
    {{ ref('stg_country_region') }} crg
ON 
    cr.customer_id = crg.customer_id