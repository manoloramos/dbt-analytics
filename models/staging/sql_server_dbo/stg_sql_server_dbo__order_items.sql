WITH src_ORDER_ITEMS AS (
    SELECT * 
        FROM {{ source('sql_server_dbo', 'ORDER_ITEMS') }}
),

ORDER_ITEMS_output AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['order_id']) }} AS order_id
        , {{ dbt_utils.generate_surrogate_key(['product_id']) }} AS product_id
        , quantity::NUMERIC AS product_quantity
        , {{ format_fivetran_fields('_fivetran_synced', '_fivetran_deleted') }}

    FROM src_ORDER_ITEMS
)

SELECT * FROM ORDER_ITEMS_output
