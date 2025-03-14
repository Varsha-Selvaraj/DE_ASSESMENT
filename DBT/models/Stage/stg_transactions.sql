{{ config(
    tags=['stage', 'transactions']
) }}

WITH cte_cleaned_data AS (
    SELECT  
        {{ cast_cols({
            'customer_id': 'INT',
            'revenue': 'DECIMAL(10,3)',
            'quantity': 'INT',
            'product_id': 'VARCHAR(200)',
            'payment_mode': 'DATE',
            'companies': 'VARCHAR(100)'
        }) }}

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
    FROM {{ source('sources', 'TRANSACTIONS') }}
    WHERE {{ not_null([
        'customer_id', 'product_id', 'payment_mode', 'revenue', 'quantity',
        'dimension_1', 'dimension_2', 'dimension_3', 'dimension_4', 'dimension_5',
        'dimension_6', 'dimension_7', 'dimension_8', 'dimension_9', 'dimension_10',
        'companies'
    ]) }}
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
