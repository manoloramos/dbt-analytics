WITH stg_orders AS (
    SELECT
        order_id,
        created_at AS order_date,
        estimated_delivery_at AS estimated_delivery_date,
        delivered_at AS delivered_date
    FROM {{ ref('stg_sql_server_dbo__orders') }} AS o
        LEFT JOIN {{ ref('stg_sql_server_dbo__events_orders' }} AS eo
            ON o.order_id = eo.order_id
)

SELECT
    COUNT(*) AS failed_tests
FROM stg_orders
WHERE
    order_date >= estimated_delivery_date OR
    order_date >= delivered_date
