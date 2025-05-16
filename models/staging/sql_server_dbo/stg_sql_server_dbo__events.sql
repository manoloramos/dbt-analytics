WITH src_events AS (
    SELECT * 
        FROM {{ source('sql_server_dbo', 'EVENTS') }}
),

events_output AS (
    SELECT
        event_id::VARCHAR AS event_id
        , page_url::VARCHAR AS page_url
        , event_type::VARCHAR AS event_type
        , user_id::VARCHAR AS user_id
        , session_id::VARCHAR AS session_id
        , {{ format_dates('created_at', {{ var('project_timezone') }}) }} AS created_at
        , {{ format_fivetran_fields('_fivetran_synced', '_fivetran_deleted') }}
        , order_id::VARCHAR AS -- Remove
        , product_id::VARCHAR AS -- Remove
    FROM src_events
)

SELECT * FROM events_output