WITH stg_users AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__users') }}
),

mart_users AS (
    SELECT
        user_id
        , first_name
        , last_name
        , address_id
        , phone_number
        , email
        , created_at
        , updated_at
    FROM stg_users
)

SELECT * FROM mart_users