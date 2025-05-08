{{
  config(
    materialized='view'
  )
}}

WITH src_users AS (
    SELECT * 
        FROM {{ source('sql_server_dbo', 'USERS') }}
),
/*
-- TODO: to maintain the total_orders field, create a base for USERS and ORDERS
total_orders_calculated AS (
    SELECT
        COUNT(*) AS total_orders
    FROM ORDERS AS o
        INNER JOIN USERS AS u
            ON u.user_id = o.user_id
    GROUP BY u.user_id;
)*/

-- Validate email and phone_number
users_output AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['user_id']) }} AS user_id
        , updated_at::DATE AS updated_at
        , address_id::VARCHAR AS address_id
        , last_name::VARCHAR AS last_name
        , created_at::DATE AS created_at
        , phone_number::VARCHAR AS phone_number
        , first_name::VARCHAR AS first_name
        , email::VARCHAR AS email
         , {{ format_fivetran_fields('_fivetran_deleted', '_fivetran_synced') }}
    FROM src_users
)

SELECT * FROM users_output
/*UNION ALL
SELECT * FROM total_orders_calculated*/