WITH src_event_types AS (
    SELECT * 
        FROM {{ ref('base_sql_server_dbo__events') }}
),

event_types_output AS (
    SELECT
        
    FROM src_events
)

SELECT * FROM event_types_output