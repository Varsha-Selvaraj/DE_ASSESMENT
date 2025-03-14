
  
    

        create or replace transient table HEALTHCARE.mart.retention_revenue
         as
        (

WITH cte_monthly_revenue AS (
    SELECT 
        payment_date, 
        SUM(REVENUE) AS total_revenue,
        SUM(CASE WHEN REVENUE > 0 THEN REVENUE ELSE 0 END) AS retained_revenue,
        SUM(CASE WHEN REVENUE < 0 THEN REVENUE ELSE 0 END) AS churned_revenue
    FROM HEALTHCARE.stage.stg_transactions
    GROUP BY payment_date
)

SELECT 
    payment_date,
    retained_revenue / total_revenue AS GRR,
    (retained_revenue + churned_revenue) / total_revenue AS NRR
FROM cte_monthly_revenue
        );
      
  