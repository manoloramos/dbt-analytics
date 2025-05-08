{{
  config(
    materialized='view'
  )
}}

WITH src_ORDER_ITEMS AS (
    SELECT * 
        FROM {{ source('sql_server_dbo', 'ORDER_ITEMS') }}

),

ORDER_ITEMS_output AS (
    SELECT
        order_id,
        product_id,
        quantity,
        _fivetran_deleted,
        _fivetran_synced

    FROM src_ORDER_ITEMS

)

SELECT * FROM ORDER_ITEMS_output
