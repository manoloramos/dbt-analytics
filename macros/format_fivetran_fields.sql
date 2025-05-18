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

{% macro format_fivetran_fields(synced, deleted = None) %}
  {% if deleted is not none %}
    COALESCE({{ deleted }}::BOOLEAN, FALSE) AS is_deleted,
  {% endif %}
  CONVERT_TIMEZONE('{{ var('project_timezone')}}', {{ synced }}::TIMESTAMP) AS date_loaded
{% endmacro %}

