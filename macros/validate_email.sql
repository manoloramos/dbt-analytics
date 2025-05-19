{% test validate_email(email_field, model) %}
    SELECT
        {{ email_field }}
    FROM {{ model }}
    WHERE {{ email_field }} ~ '^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$'
{% endtest %}
