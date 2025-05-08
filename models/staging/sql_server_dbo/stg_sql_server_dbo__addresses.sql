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
        {{ dbt_utils.generate_surrogate_key(['address_id']) }} AS address_id -- Cast?
        , zipcode::INT AS zipcode
        , country::VARCHAR AS country
        , address::VARCHAR AS address
        , state::VARCHAR AS state
        , _fivetran_synced AS date_loaded -- Cast?
        , _fivetran_deleted AS date_deleted -- Cast?
    FROM src_ADDRESSES
    )

SELECT * FROM ADDRESSES_output