WITH src_EVENTS AS (
    SELECT * 
        FROM {{ source('sql_server_dbo', 'EVENTS') }}
),


EVENTS_output AS (
    SELECT
        event_id
        , page_url
        , event_type
        , user_id
        , product_id
        , session_id
        , created_at
        , order_id
        , {{ format_fivetran_fields('_fivetran_synced', '_fivetran_deleted') }}
    FROM src_EVENTS
)

SELECT * FROM EVENTS_output