{% macro calculate_extended_cost(quantity, price) %}
    {{ quantity }} * {{ price }}
{% endmacro %}