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

{% macro format_fivetran_fields(_fivetran_deleted = none, _fivetran_synced) %}
  {% if _fivetran_deleted is not none %}
    {{ _fivetran_deleted }}::BOOLEAN AS is_deleted,
  {% endif %}
  CONVERT_TIMEZONE('{{ var('project_timezone')}}', {{ _fivetran_synced }}::TIMESTAMP) AS date_loaded
{% endmacro %}
