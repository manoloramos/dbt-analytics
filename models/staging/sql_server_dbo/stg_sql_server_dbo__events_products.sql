WITH events AS (
    SELECT 
        event_id,
        event_type_id,
        product_id
    FROM {{ ref('base_sql_server_dbo__events') }}
    WHERE product_id IS NOT NULL -- Sacamos solo los eventos que son productos
)

SELECT
    *
FROM events 