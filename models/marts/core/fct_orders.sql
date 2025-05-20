WITH stg_order_items AS (
    SELECT
        *
    FROM {{ ref('stg_sql_server_dbo__order_items') }}
),

stg_orders AS (
    SELECT
        *
    FROM {{ ref('stg_sql_server_dbo__orders') }}
),

stg_products AS(
    SELECT
        *
    FROM {{ ref('stg_sql_server_dbo__products') }}
),

fct_orders AS (
    SELECT
        oi.order_id
        , o.user_id
        , o.address_id
        , o.status AS actual_status
        , o.created_at AS order_date
        , o.created_at_timestamp AS order_timestamp
        , o.estimated_delivery_at AS estimated_delivery_date
        , o.estimated_delivery_at_timestamp AS estimated_delivery_timestamp
        , o.delivered_at AS delivered_date
        , o.delivered_at_timestamp AS delivered_timestamp
        , o.shipping_service
        , o.tracking_id
        , oi.product_id -- A partir de aqui es linea por linea de ticket
        , oi.product_quantity AS line_quantity
        , p.product_price AS line_unit_price
        , {{ calculate_extended_cost('oi.product_quantity','p.product_price') }} AS line_extended_price
        , o.order_cost -- Total de transaccional
        , o.shipping_cost
        , o.order_total -- total con shipping de transaccional
        , o.is_deleted AS order_deleted
        , oi.is_deleted AS order_line_delete
    FROM stg_order_items AS oi
    INNER JOIN stg_orders AS o
        ON oi.order_id = o.order_id
    INNER JOIN stg_products AS p
        ON oi.product_id = p.product_id
    )

SELECT * FROM fct_orders