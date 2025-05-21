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
),

current_month AS (
    SELECT
        dp.product_id AS id_producto,
        dp.product_name AS nombre_producto,
        SUM(fo.line_extended_price) AS ventas_actuales
    FROM fct_orders AS fo
        INNER JOIN dim_products AS dp ON fo.product_id = dp.product_id
    WHERE MONTH(fo.order_date) = MONTH(CURRENT_DATE())
        AND YEAR(fo.order_date) = YEAR(CURRENT_DATE())
    GROUP BY dp.product_id, dp.product_name
),

previous_month AS (
    SELECT
        dp.product_id AS id_producto,
        dp.product_name AS nombre_producto,
        SUM(fo.line_extended_price) AS ventas_anteriores
    FROM fct_orders AS fo
        INNER JOIN dim_products AS dp ON fo.product_id = dp.product_id
    WHERE MONTH(fo.order_date) = MONTH(CURRENT_DATE()) - 1
        AND YEAR(fo.order_date) = CASE
            WHEN MONTH(CURRENT_DATE()) = 1 THEN YEAR(CURRENT_DATE()) - 1
            ELSE YEAR(CURRENT_DATE())
        END
    GROUP BY dp.product_id, dp.product_name
)

SELECT
    TOP 10
    cm.id_producto,
    cm.nombre_producto,
    cm.ventas_actuales,
    COALESCE(pm.ventas_anteriores, 0) AS ventas_anteriores,
    CASE
        WHEN COALESCE(pm.ventas_anteriores, 0) = 0 THEN 0
        ELSE ROUND((cm.ventas_actuales - pm.ventas_anteriores) * 100.0 / pm.ventas_anteriores, 2)
    END AS crecimiento_mom
FROM current_month AS cm
    LEFT JOIN previous_month AS pm ON cm.id_producto = pm.id_producto
ORDER BY crecimiento_mom DESC;
