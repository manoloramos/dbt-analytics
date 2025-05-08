WITH src_ORDERS AS (
    SELECT * 
        FROM {{ source('sql_server_dbo', 'ORDERS') }}
),


ORDERS_output AS (
    SELECT
        order_id
        , shipping_service
        , shipping_cost
        , address_id
        , created_at
        , promo_id
        , estimated_delivery_at
        , order_cost
        , user_id
        , CAST(order_total AS FLOAT) AS order_total
        , delivered_at
        , tracking_id
        , status
        , {{ format_fivetran_fields('_fivetran_deleted', '_fivetran_synced') }}
    FROM src_ORDERS
)

SELECT * FROM ORDERS_output