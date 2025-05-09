WITH src_budget AS (
    SELECT * 
    FROM {{ source('google_sheets', 'BUDGET') }}
),

renamed_casted AS (
    SELECT
          _row::INT as _row
        , product_id::VARCHAR AS product_id
        , quantity::INT AS quantity
        , month::DATE AS month -- Check for necessary transformations
        , {{ format_fivetran_fields('_fivetran_synced') }}
    FROM src_budget
)

SELECT * FROM renamed_casted