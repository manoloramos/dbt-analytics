{% macro format_dates(date, timezone) %}
  CONVERT_TIMEZONE('{{ timezone }}', {{ date }}::TIMESTAMP) AS converted_date
{% endmacro %}