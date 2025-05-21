/*
- ha ha ha, no has dicho la palabra mágica :)

-- ha 	    ha 	    ha

  , ; ,   .-'"""'-.   , ; ,
  \\|/  .'         '.  \|//
   \-;-/   ()   ()   \-;-/
   // ;               ; \\
  //__; :.         .; ;__\\
 `-----\'.'-.....-'.'/-----'
        '.'.-.-,_.'.'
hah       '(  (..-'

*/

/*
    Macro that returns a date in the appropriate timezone for the project .
    Usage: {{ format_dates('created_at', var('timezone')) }} AS 'desired_camp'
*/

{% macro format_dates(date_column, timezone) %}
    CONVERT_TIMEZONE('{{ timezone }}', {{ date_column }})
{% endmacro %}


/*
    Format fivetran fields. Can accepet 1 or 2 arguments.
    How to use: {{ format_fivetran_fields('_fivetran_synced', '_fivetran_deleted') }}
*/

{% macro format_fivetran_fields(synced, deleted = None) %}
    {% if deleted is not none %}
        COALESCE({{ deleted }}, FALSE) AS is_deleted,
    {% endif %}
  CONVERT_TIMEZONE('{{ var('project_timezone')}}', {{ synced }}::TIMESTAMP) AS date_loaded
{% endmacro %}

