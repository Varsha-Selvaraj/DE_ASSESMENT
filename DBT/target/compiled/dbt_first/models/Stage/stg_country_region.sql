

WITH cte_remove_duplicates AS (
    SELECT 
        customer_id,
        country,
        region
    FROM HEALTHCARE.RAW.COUNTRY_REGION
    WHERE 
    
        customer_id IS NOT NULL
         AND 
    
        country IS NOT NULL
         AND 
    
        region IS NOT NULL
        
    

), 
cte_cleaned_data AS (
    SELECT 
        CAST(customer_id AS NUMBER(38,0)) AS customer_id,
        CAST(country AS VARCHAR(200)) AS country,
        CAST(region AS VARCHAR(200)) AS region,
        UPPER(TRIM(country)) AS cleaned_country,
        INITCAP(TRIM(region)) AS cleaned_region
    FROM HEALTHCARE.RAW.COUNTRY_REGION
    WHERE 
    
        customer_id IS NOT NULL
         AND 
    
        country IS NOT NULL
         AND 
    
        region IS NOT NULL
        
    

)

SELECT 
    customer_id,
    cleaned_country AS country,
    cleaned_region AS region
FROM cte_cleaned_data