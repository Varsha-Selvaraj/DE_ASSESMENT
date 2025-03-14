
  
    

        create or replace transient table HEALTHCARE.stage.stg_customers
         as
        (

WITH cte_handle_null AS (
    SELECT 
        customer_id,
        INITCAP(TRIM(customer_name)) AS customer_name,
        TRIM(company) AS company
    FROM HEALTHCARE.RAW.CUSTOMERS
    WHERE 
    
        customer_id IS NOT NULL
         AND 
    
        customer_name IS NOT NULL
         AND 
    
        company IS NOT NULL
        
    
  
),

cte_final AS (
    SELECT 
    DISTINCT
        
    
        CAST(customer_id AS INT) AS customer_id,
    
        CAST(customer_name AS VARCHAR(300)) AS customer_name,
    
        CAST(company AS VARCHAR(100)) AS company,
    

    FROM cte_handle_null
)

SELECT * FROM cte_final
        );
      
  