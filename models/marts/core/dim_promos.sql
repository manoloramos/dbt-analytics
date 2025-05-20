WITH stg_promos AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__promos') }}
),

mart_promos AS (
    SELECT
        promo_id
        , promo_desc
        , status
        , discounted_quantity
    FROM stg_promos
)

SELECT * FROM mart_promos