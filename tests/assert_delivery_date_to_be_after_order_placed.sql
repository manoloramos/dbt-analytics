/*
    Asegura que la fecha de creación del pedido sea siempre menor a la de estimación de entrega y a la de entrega final.
*/

SELECT
    order_id,
    order_date,
    estimated_delivery_date,
    delivered_date
FROM {{ ref('fct_orders') }}
WHERE
    order_date >= estimated_delivery_date OR
    order_date >= delivered_date