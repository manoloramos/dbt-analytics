WITH promo_statuses AS (
    SELECT
        status
    FROM {{ ref('stg_sql_server_dbo__promos') }}
)

new_statuses AS (
    SELECT 
        {{ dbt_utils.generate_surrogate_key(['status']) }} AS status_id
        status::VARCHAR AS status_description
    FROM promo_statuses
)

SELECT * FROM new_statuses