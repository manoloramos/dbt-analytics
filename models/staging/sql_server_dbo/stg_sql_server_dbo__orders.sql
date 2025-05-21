WITH src_ORDERS AS (
    SELECT * 
        FROM {{ source('sql_server_dbo', 'ORDERS') }}
),

ORDERS_output AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['order_id']) }} AS order_id
        , {{ dbt_utils.generate_surrogate_key(['tracking_id']) }} AS tracking_id
        , status::VARCHAR AS status
        , order_cost::NUMERIC(30,2) AS order_cost
        , shipping_service::VARCHAR AS shipping_service
        , shipping_cost::NUMERIC(30,2) AS shipping_cost
        , order_total::NUMERIC(30,2) AS order_total
        , created_at::DATE AS created_at
        , {{ format_dates('created_at', var('project_timezone'))}}::TIMESTAMP AS created_at_timestamp
        , estimated_delivery_at::DATE AS estimated_delivery_at
        , {{ format_dates('estimated_delivery_at', var('project_timezone'))}}::TIMESTAMP AS estimated_delivery_at_timestamp -- Check for nulls
        , delivered_at::DATE AS delivered_at
        , {{ format_dates('delivered_at', var('project_timezone'))}}::TIMESTAMP AS delivered_at_timestamp -- Check for nulls
        , {{ dbt_utils.generate_surrogate_key(['promo_id']) }} AS promo_id
        , {{ dbt_utils.generate_surrogate_key(['user_id']) }} AS user_id
        , {{ dbt_utils.generate_surrogate_key(['address_id']) }} AS address_id
        , {{ format_fivetran_fields('_fivetran_synced', '_fivetran_deleted') }}
    FROM src_ORDERS
)

SELECT * FROM ORDERS_output