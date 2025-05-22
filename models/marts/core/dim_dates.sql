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
  date_day AS date
  , YEAR(date_day) AS year
  , MONTH(date_day) AS month
  , {{ dbt_date.month_name('date_day', short=False) }} AS month_name
  , CASE EXTRACT(DAYOFWEEK FROM date_day)
        WHEN 0 THEN 'Sunday'
        WHEN 1 THEN 'Monday'
        WHEN 2 THEN 'Tuesday'
        WHEN 3 THEN 'Wednesday'
        WHEN 4 THEN 'Thursday'
        WHEN 5 THEN 'Friday'
        WHEN 6 THEN 'Saturday'
    END AS day_name
  , COALESCE(NULLIF(EXTRACT(DAYOFWEEK FROM date_day), '0'), '7') AS day_of_week
  , EXTRACT(DAYOFYEAR FROM date_day) AS day_of_year
  , EXTRACT(WEEK FROM date_day) AS week
  , EXTRACT(QUARTER FROM date_day) AS quarter
  , CASE EXTRACT(QUARTER FROM date_day)
        WHEN 1 THEN 'First'
        WHEN 2 THEN 'Second'
        WHEN 3 THEN 'Third'
        WHEN 4 THEN 'Fourth'
    END AS quarter_name
  , CASE 
        WHEN EXTRACT(DAYOFWEEK FROM date_day) IN (6, 0) THEN TRUE
    ELSE FALSE
  END AS is_weekend
FROM filtered_spine