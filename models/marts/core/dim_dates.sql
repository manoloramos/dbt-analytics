{{
  config(
    materialized='incremental',
    unique_key='date'
  )
}}

-- Day has to be the dayname
-- Day of week has to start on 1 and end on 7

WITH date_spine AS (
  {{ dbt_utils.date_spine(
    datepart="day",
    start_date="cast('2021-02-01' as date)",
    end_date="DATEADD(year, 1, CURRENT_DATE)"
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
  MONTH(date_day) AS month,
  DAY(date_day) AS day,
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