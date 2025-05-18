SELECT 
    event_id
    , event_type_id
    , order_id
FROM {{ ref('base_sql_server_dbo__events') }}
WHERE order_id IS NOT NULL 