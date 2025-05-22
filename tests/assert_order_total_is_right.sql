SELECT
    order_id,
    order_total,
    shipping_cost,
    SUM(line_extended_price) AS total_amount,
FROM {{ ref('fct_orders') }}
GROUP BY 1,2,3
HAVING total_amount+shipping_cost != order_total