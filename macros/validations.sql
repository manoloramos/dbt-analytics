-- Validate a phone field to match US format
{% test validate_phone(column_name, model) %}
    {{ config(severity = 'warn') }}

    SELECT
        {{ column_name }}
    FROM {{ model }}
    WHERE {{ column_name }} NOT RLIKE '^[0-9]{3}-[0-9]{3}-[0-9]{4}$'
{% endtest %}

-- Validate the format of an email field 
{% test validate_email(column_name, model) %}
    {{ config(severity = 'warn') }}

    SELECT
        {{ column_name }}
    FROM {{ model }}
    WHERE {{ column_name }} NOT RLIKE '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
{% endtest %}
