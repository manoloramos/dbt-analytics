SELECT
    event_id
    , page_url
    , event_type
    , user_id
    , session_id
    , created_at
    , is_deleted
    , date_loaded
FROM {{ ref('base_sql_server_dbo__events') }}