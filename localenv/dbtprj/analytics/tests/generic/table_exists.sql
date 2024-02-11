{% test table_exists(model, table_name) %}

WITH TABLE_EXISTS AS
(
    SELECT EXISTS (
        SELECT 1 as flg
        FROM `{{ model.database }}.{{ model.schema }}.INFORMATION_SCHEMA.TABLES`
        WHERE table_name = '{{ table_name }}'
    ) FLG
)
SELECT * FROM TABLE_EXISTS WHERE FLG = false

{% endtest %}
