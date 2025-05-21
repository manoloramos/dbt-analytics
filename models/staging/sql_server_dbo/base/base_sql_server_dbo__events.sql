/*
    Events Base - Initial transformations for the Events source
*/

SELECT
    {{ dbt_utils.generate_surrogate_key(['event_id']) }} AS event_id
    , page_url::VARCHAR AS page_url
    , {{ dbt_utils.generate_surrogate_key(['user_id']) }} AS user_id
    , {{ dbt_utils.generate_surrogate_key(['event_type']) }} AS event_type_id
    , INITCAP(REGEXP_REPLACE(event_type, '[^a-zA-Z0-9]+', ' ')) AS event_type
    , {{ dbt_utils.generate_surrogate_key(['product_id']) }} AS product_id
    , {{ dbt_utils.generate_surrogate_key(['order_id']) }} AS order_id
    , {{ dbt_utils.generate_surrogate_key(['session_id']) }} AS session_id
    , TO_CHAR(created_at, 'YYYY-DD-MM') AS created_at
    , CONVERT_TIMEZONE('{{ var('project_timezone') }}', TO_CHAR(created_at, 'YYYY-DD-MM HH24:MI:SS')) AS created_at_timestamp
    , {{ format_fivetran_fields('_fivetran_synced', '_fivetran_deleted') }}
FROM {{ source('sql_server_dbo', 'EVENTS') }}
ORDER BY created_at