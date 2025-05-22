/*
    El total de la venta en la columna 'order_cost' debe coincidir con la suma de los precios extendidos de los productos 'total_amount'.
    Si hay diferencias, significa que los datos de las ventas y sus productos no están calculados correctamente en las fuentes.
    Por lo cual, este test devolverá los registros donde `total_amount` y `order_cost` no coincidan, para hacer que falle el test.
*/

SELECT
    order_id,
    SUM(line_extended_price) AS total_amount,
    order_cost
FROM {{ ref('fct_orders') }}
GROUP BY 1,3
HAVING total_amount != order_cost