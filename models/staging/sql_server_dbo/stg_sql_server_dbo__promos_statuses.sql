WITH promo_statuses AS (
    SELECT
        status
    FROM {{ ref('base_sql_server_dbo__promos_statuses') }}
),

promos_statuses_output AS (
    SELECT 
        *
    FROM promo_statuses
)

SELECT * FROM promos_statuses_output