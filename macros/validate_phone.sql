{% test validate_email(phone_number_field, model) %}
    SELECT
        {{ phone_number_field }}
    FROM {{ model }}
    WHERE {{ phone_number_field }} ~ '^[0-9]{3}-[0-9]{3}-[0-9]{4}$'
{% endtest %}
