WITH src_budget AS (
    SELECT * 
    FROM {{ source('google_sheets', 'BUDGET') }}
),

renamed_casted AS (
    SELECT
          _row::INT AS id_budget
        , quantity::INT AS quantity
        , month AS date
        , YEAR(month) AS year
        , MONTH(month) AS month
        , MONTHNAME(month) AS month_name
        , {{ dbt_utils.generate_surrogate_key(['product_id']) }} AS product_id
        , {{ format_fivetran_fields('_fivetran_synced') }}
    FROM src_budget
)

SELECT * FROM renamed_casted