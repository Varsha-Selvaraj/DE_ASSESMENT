

WITH cte_not_null AS (
    SELECT 
        TRIM(product_id) AS product_id, 
        TRIM(product_family) AS product_family, 
        TRIM(product_sub_family) AS product_sub_family
    FROM HEALTHCARE.RAW.PRODUCTS
    WHERE 
    
        product_id IS NOT NULL
         AND 
    
        product_family IS NOT NULL
         AND 
    
        product_sub_family IS NOT NULL
        
    

),

cte_final AS (
    SELECT 
    DISTINCT
        
    
        CAST(product_id AS VARCHAR(500)) AS product_id,
    
        CAST(product_family AS VARCHAR(500)) AS product_family,
    
        CAST(product_sub_family AS VARCHAR(500)) AS product_sub_family,
    

    FROM cte_not_null
)

SELECT * FROM cte_final