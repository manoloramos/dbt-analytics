WITH src_budget AS (
    SELECT * 
    FROM {{ source('google_sheets', 'BUDGET') }}
),

renamed_casted AS (
    SELECT
          _row
        , product_id 
        , quantity
        , month
        , _fivetran_synced AS date_load
        , {{ format_fivetran_fields(_fivetran_synced=_fivetran_synced) }}
        -- checar
    FROM src_budget
)

SELECT * FROM renamed_casted

