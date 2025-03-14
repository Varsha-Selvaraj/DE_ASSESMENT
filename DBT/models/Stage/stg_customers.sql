{{ config(
    tags=['stage', 'customers']
) }}

WITH cte_handle_null AS (
    SELECT 
        customer_id,
        INITCAP(TRIM(customer_name)) AS customer_name,
        TRIM(company) AS company
    FROM {{ source('sources', 'CUSTOMERS') }}
    WHERE {{ not_null(['customer_id', 'customer_name', 'company']) }}  
),

cte_final AS (
    SELECT 
    DISTINCT
        {{ cast_cols({
            'customer_id': 'INT',
            'customer_name': 'VARCHAR(300)',
            'company': 'VARCHAR(100)'
        }) }}
    FROM cte_handle_null
)

SELECT * FROM cte_final
