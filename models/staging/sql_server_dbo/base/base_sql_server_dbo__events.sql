SELECT
    {{ dbt_utils.generate_surrogate_key(['event_id']) }} AS event_id
    , page_url::VARCHAR AS page_url
    , {{ dbt_utils.generate_surrogate_key(['user_id']) }} AS user_id
    , {{ dbt_utils.generate_surrogate_key(['event_type']) }} AS event_type_id
    , INITCAP(REGEXP_REPLACE(event_type, '[^a-zA-Z0-9]+', ' ')) AS event_type
    , {{ dbt_utils.generate_surrogate_key(['product_id']) }} AS product_id
    , {{ dbt_utils.generate_surrogate_key(['order_id']) }} AS order_id
    , {{ dbt_utils.generate_surrogate_key(['session_id']) }} AS session_id
    , {{ format_dates('created_at', var('project_timezone')) }} AS created_at
    , {{ format_fivetran_fields('_fivetran_synced', '_fivetran_deleted') }}
FROM {{ source('sql_server_dbo', 'EVENTS') }}
ORDER BY created_at