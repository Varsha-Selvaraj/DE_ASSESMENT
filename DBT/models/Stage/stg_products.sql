{{ config(
    tags=['stage', 'products']
) }}

WITH cte_not_null AS (
    SELECT 
        TRIM(product_id) AS product_id, 
        TRIM(product_family) AS product_family, 
        TRIM(product_sub_family) AS product_sub_family
    FROM {{ source('sources', 'PRODUCTS') }}
    WHERE {{ not_null(['product_id', 'product_family', 'product_sub_family']) }}
),

cte_final AS (
    SELECT 
    DISTINCT
        {{ cast_cols({
            'product_id': 'VARCHAR(500)',
            'product_family': 'VARCHAR(500)',
            'product_sub_family': 'VARCHAR(500)'
        }) }}
    FROM cte_not_null
)

SELECT * FROM cte_final
