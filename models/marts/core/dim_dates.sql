{{
  config(
    materialized='incremental',
    unique_key='date'
  )
}}

WITH date_spine AS (
  {{ dbt_utils.date_spine(
    datepart="day",
    start_date="cast('2018-01-01' as date)",
    end_date="DATEADD(year, 3, CURRENT_DATE)"
  ) }}
),

filtered_spine AS (
  SELECT *
  FROM date_spine
  {% if is_incremental() %}
    WHERE date_day > (SELECT MAX(date) FROM {{ this }})
  {% endif %}
)

SELECT
  date_day AS date,
  YEAR(date_day) AS year,
  EXTRACT(MONTH FROM date_day) AS month,
  EXTRACT(DAY FROM date_day) AS day,
  TO_CHAR(date_day, 'Day') AS day_name,
  EXTRACT(DAYOFWEEK FROM date_day) AS day_of_week,
  EXTRACT(DAYOFYEAR FROM date_day) AS day_of_year,
  EXTRACT(WEEK FROM date_day) AS week,
  EXTRACT(QUARTER FROM date_day) AS quarter,
  CASE 
    WHEN EXTRACT(DAYOFWEEK FROM date_day) IN (1, 7) THEN TRUE
    ELSE FALSE
  END AS is_weekend
FROM filtered_spine