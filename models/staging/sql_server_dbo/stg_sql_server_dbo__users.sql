{{
  config(
    materialized='view'
  )
}}

WITH src_USERS AS (
    SELECT * 
        FROM {{ source('sql_server_dbo', 'USERS') }}
    ),


USERS_output AS (
    SELECT
        user_id
        , updated_at
        , address_id
        , last_name
        , created_at
        , phone_number
        , total_orders
        , first_name
        , email
        , _fivetran_synced AS date_loaded
        , _fivetran_deleted AS date_deleted
    FROM src_USERS
    )

SELECT * FROM USERS_output