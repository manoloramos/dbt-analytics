SELECT 
    {{ dbt_utils.generate_surrogate_key(['status']) }} AS status_id
    , status::VARCHAR AS status_description
FROM FROM {{ ref('stg_sql_server_dbo__promos') }}
