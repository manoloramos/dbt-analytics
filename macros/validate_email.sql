{% macro validate_email(email) %}
    CASE
        WHEN {{ email }} ~ '^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$' THEN {{ email }}::VARCHAR
        ELSE NULL
    END AS {{ email }}
{% endmacro %}