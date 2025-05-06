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
        {{ dbt_utils.generate_surrogate_key('promo_id') }} AS promo_id
        , promo_id AS desc_promo
        , discount
        , status
        , _fivetran_synced AS date_loaded
        , _fivetran_deleted AS date_deleted
    FROM src_PROMOS
)

SELECT * FROM PROMOS_output