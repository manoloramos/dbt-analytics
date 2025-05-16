WITH src_ORDER_ITEMS AS (
    SELECT * 
        FROM {{ source('sql_server_dbo', 'ORDER_ITEMS') }}
),

ORDER_ITEMS_output AS (
    SELECT
        order_id
        , product_id
        , quantity
        , {{ format_fivetran_fields('_fivetran_synced', '_fivetran_deleted') }}

    FROM src_ORDER_ITEMS
)

SELECT * FROM ORDER_ITEMS_output
