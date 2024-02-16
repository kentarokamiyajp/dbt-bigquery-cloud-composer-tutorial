{% set query %}
select 
    count(distinct id)
from 
    {{ source('TRVANALYT_RAW','RESERVATION_D_BOOKINGS') }}
order by 1
{% endset %}

{% set results = run_query(query) %}

{% if execute %}
    {# Return the first column #}
    {% set row_counts = results.columns[0].values()[0] %}
    {% if row_counts == 0 %}
        {{ exceptions.raise_compiler_error("Invalid `row_counts`. Got: " ~ row_counts) }}
    {% else %}
        WITH TMP_1 AS (
            SELECT
                id,
                dt
            FROM {{ source('TRVANALYT_RAW','RESERVATION_D_BOOKINGS') }}
        ),
        TMP_2 AS (
            SELECT
                id,
                dt
            FROM {{ source('TRVANALYT_RAW','RESERVATION_D_BOOKINGS') }}
        ),
        FINAL AS (
            SELECT * FROM TMP_1
            UNION ALL
            SELECT * FROM TMP_2
        )
        SELECT * FROM FINAL
    {% endif %}
{% endif %}

