{{
  config(
    materialized='view'
  )
}}

WITH src_products AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'PRODUCTS') }}

    UNION ALL

    SELECT
       'no product' AS product_id,
       0.0 AS price,
       'no product' AS name,
       0 AS inventory,
       NULL AS date_delete,
       CONVERT_TIMEZONE('UTC', CURRENT_TIMESTAMP) AS date_load
    ),

products_output AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['product_id']) }} AS product_id,
        price::FLOAT AS price,
        name::VARCHAR AS name,
        inventory::INT AS inventory,
        _fivetran_deleted::BOOLEAN AS is_deleted,
        CONVERT_TIMEZONE('UTC', _fivetran_synced::TIMESTAMP) AS date_loaded
    FROM src_products
    )

SELECT * FROM products_output