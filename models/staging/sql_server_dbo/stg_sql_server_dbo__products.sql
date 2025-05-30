WITH src_products AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'PRODUCTS') }}
),

products_output AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['product_id']) }} AS product_id
        , price::NUMERIC(35, 2) AS price
        , name::VARCHAR AS name
        , inventory::INT AS inventory
        , {{ format_fivetran_fields('_fivetran_synced', '_fivetran_deleted') }}
    FROM src_products
)

SELECT * FROM products_output