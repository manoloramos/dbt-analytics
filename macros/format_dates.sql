/*
    Macro that returns a date in the appropriate timezone for the project .
    How to use: {{ format_dates('created_at', var('timezone')) }} AS 'desired_camp'
*/

{% macro format_dates(date, timezone) %}
  CONVERT_TIMEZONE('{{ timezone }}', {{ date }})
{% endmacro %}