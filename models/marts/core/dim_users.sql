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
        , phone_number::VARCHAR AS phone_number -- Validate
        -- incorrect phone field
        , email::VARCHAR AS email -- Validate
        -- incorrect email field
        , created_at
        , updated_at
    FROM stg_users
)

SELECT * FROM mart_users