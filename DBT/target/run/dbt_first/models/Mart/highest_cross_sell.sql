
  
    

        create or replace transient table HEALTHCARE.mart.highest_cross_sell
         as
        (

WITH cte_customer_product_count AS (
    SELECT 
        customer_id,
        COUNT(DISTINCT product_id) AS product_count
    FROM 
        HEALTHCARE.stage.stg_transactions
    GROUP BY 
        customer_id
),
cte_highest_cross_sell AS (
    SELECT 
        customer_id,
        product_count,
        DENSE_RANK() OVER(ORDER BY product_count DESC) AS cross_sell_rank
    FROM 
        cte_customer_product_count
)
SELECT 
    hcs.customer_id,
    c.customer_name,
    hcs.product_count,
    hcs.cross_sell_rank
FROM 
    cte_highest_cross_sell AS hcs
INNER JOIN 
      HEALTHCARE.stage.stg_customers AS c
ON 
    hcs.customer_id = c.customer_id
ORDER BY 
    hcs.cross_sell_rank
        );
      
  