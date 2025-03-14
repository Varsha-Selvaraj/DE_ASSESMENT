

WITH cte_cleaned_data AS (
    SELECT  
        
    
        CAST(customer_id AS INT) AS customer_id,
    
        CAST(revenue AS DECIMAL(10,3)) AS revenue,
    
        CAST(quantity AS INT) AS quantity,
    
        CAST(product_id AS VARCHAR(200)) AS product_id,
    
        CAST(payment_mode AS DATE) AS payment_mode,
    
        CAST(companies AS VARCHAR(100)) AS companies,
    


        CASE 
            WHEN revenue_type = 'True' THEN 1
            WHEN revenue_type = 'False' THEN 0
            ELSE NULL 
        END AS revenue_type,
        CAST(payment_mode AS DATE) AS payment_date,
        CAST(dimension_1 AS VARCHAR(10)) AS dim_1,
        CAST(dimension_2 AS VARCHAR(10)) AS dim_2,
        CAST(dimension_3 AS VARCHAR(10)) AS dim_3,
        CAST(dimension_4 AS VARCHAR(10)) AS dim_4,
        CAST(dimension_5 AS VARCHAR(10)) AS dim_5,
        CAST(dimension_6 AS VARCHAR(10)) AS dim_6,
        CAST(dimension_7 AS VARCHAR(10)) AS dim_7,
        CAST(dimension_8 AS VARCHAR(10)) AS dim_8,
        CAST(dimension_9 AS VARCHAR(10)) AS dim_9,
        CAST(dimension_10 AS VARCHAR(10)) AS dim_10
    FROM HEALTHCARE.RAW.TRANSACTIONS
    WHERE 
    
        customer_id IS NOT NULL
         AND 
    
        product_id IS NOT NULL
         AND 
    
        payment_mode IS NOT NULL
         AND 
    
        revenue IS NOT NULL
         AND 
    
        quantity IS NOT NULL
         AND 
    
        dimension_1 IS NOT NULL
         AND 
    
        dimension_2 IS NOT NULL
         AND 
    
        dimension_3 IS NOT NULL
         AND 
    
        dimension_4 IS NOT NULL
         AND 
    
        dimension_5 IS NOT NULL
         AND 
    
        dimension_6 IS NOT NULL
         AND 
    
        dimension_7 IS NOT NULL
         AND 
    
        dimension_8 IS NOT NULL
         AND 
    
        dimension_9 IS NOT NULL
         AND 
    
        dimension_10 IS NOT NULL
         AND 
    
        companies IS NOT NULL
        
    

),
cte_name_change AS(
    SELECT 
    DISTINCT
        customer_id,
        revenue,
        quantity,
        product_id,
        payment_mode AS payment_date,
        companies       AS company_name,
        revenue_type,
        dim_1,
        dim_2,
        dim_3,
        dim_4,
        dim_5,
        dim_6,
        dim_7,
        dim_8,
        dim_9,
        dim_10
    FROM 
        cte_cleaned_data
)

SELECT * FROM cte_name_change