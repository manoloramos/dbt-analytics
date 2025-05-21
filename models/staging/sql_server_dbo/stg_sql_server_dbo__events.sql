SELECT
    event_id
    , event_type_id
    , event_type
    , page_url
    , user_id
    , session_id
    , created_at
    , created_at_timestamp
    , is_deleted
    , date_loaded
FROM {{ ref('base_sql_server_dbo__events') }}