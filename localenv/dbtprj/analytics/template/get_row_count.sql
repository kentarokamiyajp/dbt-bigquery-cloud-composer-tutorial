{% macro get_row_count(table_name) %}
    {% set query %}
        SELECT COUNT(*) FROM {{ table_name }}
    {% endset %}

    {% set results = run_query(query) %}

    {% if execute %}
        {% set row_count = results.columns[0].values()[0] %}
        {{ return(row_count) }}
    {% endif %}
{% endmacro %}
