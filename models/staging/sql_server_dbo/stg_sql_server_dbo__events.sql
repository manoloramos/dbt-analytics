{{
  config(
    materialized='view'
  )
}}

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
        , _fivetran_synced AS date_loaded
        , _fivetran_deleted AS date_deleted
    FROM src_EVENTS
    )

SELECT * FROM EVENTS_output