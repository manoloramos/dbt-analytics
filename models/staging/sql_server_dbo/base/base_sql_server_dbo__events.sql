WITH events AS (
    SELECT
        *
    FROM {{ source('sql_server_dbo', 'EVENTS') }}
),

new_events AS (
    SELECT 
        {{ dbt_utils.generate_surrogate_key(['event_id']) }} AS event_id
        , page_url
        , {{ dbt_utils.generate_surrogate_key(['event_type']) }} AS event_type_id
        , INITCAP(REGEXP_REPLACE(event_type '[^a-zA-Z0-9]+' ' ')) AS event_type
        , user_id
        , product_id
        , order_id
        , {{ dbt_utils.generate_surrogate_key(['session_id']) }} AS session_id
        , created_at
        , {{ format_fivetran_fields('_fivetran_deleted', '_fivetran_synced') }}
    FROM events
    ORDER BY created_at
)

SELECT * FROM new_events