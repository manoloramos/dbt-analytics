{{
  config(
    materialized='view'
  )
}}

WITH src_ADDRESSES AS (
    SELECT * 
        FROM {{ source('sql_server_dbo', 'ADDRESSES') }}
    ),

ADDRESSES_output AS (
    SELECT
        address_id
        , zipcode
        , country
        , address
        , state
        , _fivetran_synced AS date_loaded
        , _fivetran_deleted AS date_deleted
    FROM src_ADDRESSES
    )

SELECT * FROM ADDRESSES_output