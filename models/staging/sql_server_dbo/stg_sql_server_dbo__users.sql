WITH src_users AS (
    SELECT * 
        FROM {{ source('sql_server_dbo', 'USERS') }}
),

users_output AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['user_id']) }} AS user_id
        , first_name::VARCHAR AS first_name
        , last_name::VARCHAR AS last_name
        , address_id::VARCHAR AS address_id
        , phone_number::VARCHAR AS phone_number
        , email::VARCHAR AS email
        , {{ format_dates('created_at', var('project_timezone')) }}::DATE AS created_at
        , {{ format_dates('updated_at', var('project_timezone')) }}::DATE AS updated_at
        , {{ format_fivetran_fields('_fivetran_synced', '_fivetran_deleted') }}
    FROM src_users
)

SELECT * FROM users_output