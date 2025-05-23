/*WITH stg_orders AS (
    SELECT
        order_id,
        created_at AS order_date,
        estimated_delivery_at AS estimated_delivery_date,
        delivered_at AS delivered_date
    FROM  AS o
        LEFT JOIN  AS eo
            ON o.order_id = eo.order_id
)

SELECT
    COUNT(*) AS failed_tests
FROM stg_orders
WHERE
    order_date >= estimated_delivery_date OR
    order_date >= delivered_date*/
