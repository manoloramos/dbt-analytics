WITH stg_addresses AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__addresses') }}
),

mart_addresses AS (
    SELECT
        address_id
        , zipcode
        , country
        , address
        , state
    FROM stg_addresses
)

SELECT * FROM mart_addresses