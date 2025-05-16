WITH promo_statuses AS (
    SELECT
        status
    FROM {{ ref('base_sql_server_dbo__promos_statuses') }}
)
