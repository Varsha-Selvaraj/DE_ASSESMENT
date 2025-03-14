{{ config(
    tags=['mart', 'rank_product_revenue']
) }}

-- WITH cte_product_revenue AS (
--     SELECT 
--         product_id,
--         SUM(revenue*quantity) AS total_revenue
--     FROM {{ ref('stg_transactions') }} 
--     where revenue_type = 1 and revenue > 0
--     GROUP BY 
--         product_id
-- )
-- SELECT 
--     product_id,
--     total_revenue,
--     DENSE_RANK() OVER(ORDER BY total_revenue DESC) AS product_rank
-- FROM cte_product_revenue 


WITH cte_product_revenue AS (
    SELECT 
        t.product_id, 
        p.product_family,
        SUM(t.revenue*t.quantity) AS total_revenue
    FROM {{ ref('stg_transactions') }} t
    JOIN {{ ref('stg_products') }} p
    ON t.product_id = p.product_id
    WHERE t.revenue_type = 1 
    GROUP BY t.product_id, p.product_family
)

SELECT 
    product_id, 
    product_family,
    total_revenue, 
    RANK() over (ORDER BY total_revenue DESC) AS revenue_rank
FROM cte_product_revenue