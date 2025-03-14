{{ config(
    tags=['stage', 'country_region']
) }}

WITH cte_remove_duplicates AS (
    SELECT 
        customer_id,
        country,
        region
    FROM {{ source('sources', 'COUNTRY_REGION') }}
    WHERE {{ not_null(['customer_id', 'country', 'region']) }}
), 
cte_cleaned_data AS (
    SELECT 
        CAST(customer_id AS NUMBER(38,0)) AS customer_id,
        CAST(country AS VARCHAR(200)) AS country,
        CAST(region AS VARCHAR(200)) AS region,
        UPPER(TRIM(country)) AS cleaned_country,
        INITCAP(TRIM(region)) AS cleaned_region
    FROM {{ source('sources', 'COUNTRY_REGION') }}
    WHERE {{ not_null(['customer_id', 'country', 'region']) }}
)

SELECT 
    customer_id,
    cleaned_country AS country,
    cleaned_region AS region
FROM cte_cleaned_data
