{% test validate_phone(phone_number) %}
    CASE
        WHEN {{ phone_number }} ~ '^[0-9]{3}-[0-9]{3}-[0-9]{4}$' THEN {{ phone_number }}::VARCHAR
        ELSE NULL
    END AS {{ phone_number }}
{% endtest %}
