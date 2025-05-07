{{
  config(
    materialized='view'
  )
}}

WITH src_promos AS (

    SELECT * 
    FROM {{ source('sql_server_dbo', 'PROMOS') }}

    UNION ALL

    -- Specify source origin columns, not aliases defined in SLV ouput
    -- Insert a new no_promo row
    SELECT 
        'no_promo' AS promo_id
        , 0 AS discount
        , 'inactive' AS status
        , null AS _fivetran_deleted
        , CONVERT_TIMEZONE('UTC', CURRENT_TIMESTAMP) AS _fivetran_synced
    
),

promos_output AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['promo_id']) }} AS promo_id -- Generate a surrogate key (hash) to better identify PROMOS
        , promo_id::VARCHAR AS promo_desc
        , discount::FLOAT AS discounted_quantity
        , status::VARCHAR AS status
        , _fivetran_deleted::BOOLEAN AS is_deleted
        , CONVERT_TIMEZONE('UTC', _fivetran_synced)::TIMESTAMP AS date_loaded
    FROM src_promos
)

SELECT * FROM promos_output