{{
  config(
    materialized='view'
  )
}}

WITH src_dates AS (
    SELECT * 
        FROM {{ source('sql_server_dbo', 'DATES') }}
),

 dates_output AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['date_id']) }} AS date_id 
    FROM src_dates
)

SELECT * FROM dates_output