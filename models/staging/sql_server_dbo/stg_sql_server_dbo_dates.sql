WITH src_dates AS (
    SELECT * 
        FROM {{ ref('base_sql_server_dbo__promos') }}
),

dates_output AS (
    SELECT
        *
    FROM src_dates
)

SELECT * FROM dates_output