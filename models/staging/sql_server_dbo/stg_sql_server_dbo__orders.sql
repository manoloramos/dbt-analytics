{{
  config(
    materialized='view'
  )
}}

WITH src_ORDERS AS (
    SELECT * 
        FROM {{ source('sql_server_dbo', 'ORDERS') }}
    ),


ORDERS_output AS (
    SELECT
        order_id
        , shipping_service
        , shipping_cost
        , address_id
        , created_at
        , promo_id
        , estimated_delivery_at
        , order_cost
        , user_id
        , CAST(order_total AS FLOAT) AS order_total
        , delivered_at
        , tracking_id
        , status
        , _fivetran_synced AS date_loaded
        , _fivetran_deleted AS date_deleted
    FROM src_ORDERS
    )

SELECT * FROM ORDERS_output