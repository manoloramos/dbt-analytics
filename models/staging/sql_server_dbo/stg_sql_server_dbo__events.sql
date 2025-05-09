WITH src_events AS (
    SELECT * 
        FROM {{ source('sql_server_dbo', 'EVENTS') }}
),


events_output AS (
    SELECT
        event_id::VARCHAR AS event_id
        , page_url::VARCHAR AS 
        , event_type
        , user_id::VARCHAR AS 
        , product_id::VARCHAR AS 
        , session_id::VARCHAR AS 
        , created_at
        , order_id::VARCHAR AS 
        , {{ format_fivetran_fields('_fivetran_synced', '_fivetran_deleted') }}
    FROM src_events
)

SELECT * FROM events_output