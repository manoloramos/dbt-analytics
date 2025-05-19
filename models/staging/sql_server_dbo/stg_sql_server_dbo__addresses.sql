WITH src_addresses AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'ADDRESSES') }}
),

addresses_output AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['address_id']) }} AS address_id
        , zipcode::INT AS zipcode
        , country::VARCHAR AS country
        , address::VARCHAR AS address
        , state::VARCHAR AS state
        , {{ format_fivetran_fields('_fivetran_synced', '_fivetran_deleted') }}
    FROM src_addresses
)

SELECT * FROM addresses_output