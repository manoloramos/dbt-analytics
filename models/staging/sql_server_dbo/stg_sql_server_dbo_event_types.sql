WITH src_event_types AS (
    SELECT * 
        FROM {{ ref('base_sql_server_dbo__events') }}
),

event_types_output AS (
    SELECT
        event_type_id,
        event_type
    FROM src_event_types
)

SELECT * FROM event_types_output