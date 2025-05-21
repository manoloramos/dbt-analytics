WITH dim_products AS (
    SELECT 
        product_id,
        product_name
    FROM {{ ref('dim_products') }}
),

fct_orders AS (
   SELECT  
        product_id
        , line_extended_price
   FROM {{ ref('fct_orders')}}
)

SELECT 
    TOP 10
    dp.product_id AS id_producto
    , dp.product_name AS nombre_producto
    , SUM(fo.line_extended_price) AS ventas_totales
FROM fct_orders AS fo
    LEFT JOIN dim_products AS dp ON fo.product_id = dp.product_id
GROUP BY dp.product_id, dp.product_name
ORDER BY ventas_totales DESC