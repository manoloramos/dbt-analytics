{{
  config(
    materialized='view'
  )
}}

WITH src_PROMOS AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'PROMOS') }}
    ),

PROMOS_output AS (
    SELECT
        promo_id
        , desc_promo AS promo_id
        , discount
        , status
        , _fivetran_synced AS date_loaded
        , _fivetran_deleted AS date_deleted
    FROM src_PROMOS
    )

SELECT * FROM PROMOS_output