WITH dim_products AS (
    SELECT 
        product_id,
        product_name
    FROM {{ ref('dim_products') }}
),

dim_dates AS (
    SELECT
        day
    FROM {{ ref('dim_dates') }}
),

fct_orders AS (
   SELECT  
        product_id,
        line_extended_price,
        order_date
   FROM {{ ref('fct_orders')}}
),

sales_by_product_day AS (
    SELECT
        dp.product_id AS id_producto,
        dp.product_name AS nombre_producto,
        fo.order_date AS fecha,
        TO_CHAR(fo.order_date, 'Day') AS dia,
        SUM(fo.line_extended_price) AS ventas_totales
    FROM fct_orders AS fo
        LEFT JOIN dim_products AS dp ON fo.product_id = dp.product_id
    GROUP BY dp.product_id, dp.product_name, fo.order_date
),

sales_by_product AS (
    SELECT
        dp.product_name AS nombre_producto,
        fo.order_date AS fecha,
        TO_CHAR(fo.order_date, 'Day') AS dia,
        SUM(fo.line_extended_price) AS ventas_totales,
        CASE
            WHEN LAG(SUM(fo.line_extended_price), 1) OVER (PARTITION BY dp.product_name ORDER BY fo.order_date) IS NULL THEN 0
            ELSE SUM(fo.line_extended_price) - LAG(SUM(fo.line_extended_price), 1) OVER (PARTITION BY dp.product_name ORDER BY fo.order_date)
        END AS diferencia_importe,
        CASE
            WHEN LAG(SUM(fo.line_extended_price), 1) OVER (PARTITION BY dp.product_name ORDER BY fo.order_date) IS NULL THEN 0
            ELSE (SUM(fo.line_extended_price) - LAG(SUM(fo.line_extended_price), 1) OVER (PARTITION BY dp.product_name ORDER BY fo.order_date)) / LAG(SUM(fo.line_extended_price), 1) OVER (PARTITION BY dp.product_name ORDER BY fo.order_date)
        END AS incremento_ventas_porcentaje
    FROM fct_orders AS fo
        LEFT JOIN dim_products AS dp ON fo.product_id = dp.product_id
    GROUP BY dp.product_name, fo.order_date
)

SELECT
    nombre_producto,
    fecha,
    dia,
    ventas_totales,
    CONCAT(ROUND(incremento_ventas_porcentaje * 100, 2), '%') AS incremento_ventas_porcentaje,
    ROUND(diferencia_importe, 2) AS diferencia_importe
FROM sales_by_product
WHERE nombre_producto = 'Ficus' -- Delete this
ORDER BY fecha DESC
