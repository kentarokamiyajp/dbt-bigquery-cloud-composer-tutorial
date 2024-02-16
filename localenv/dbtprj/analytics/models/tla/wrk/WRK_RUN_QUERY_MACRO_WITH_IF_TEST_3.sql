{% set payment_method_query %}
select 
    count(distinct id)
from 
    {{ source('TLA__TRVANALYT_RAW','TLA__CRYPTO_CANDLES') }}
order by 1
{% endset %}

{% set results = run_query(payment_method_query) %}

{% if execute %}
    {# Return the first column #}
    {% set row_counts = results.columns[0].values()[0] %}
    {% if row_counts == 11 %}
        select 'ALL records exist' as FLG, {{ row_counts }} as row_counts
    {% else %}
        {{ exceptions.raise_compiler_error("Invalid `row_counts`. Got: " ~ row_counts) }}
    {% endif %}
{% endif %}

