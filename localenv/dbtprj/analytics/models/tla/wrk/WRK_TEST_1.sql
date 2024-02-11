{% set payment_method_query %}
select 
    distinct
    id
from 
    {{ source('TLA__TRVANALYT_RAW','TLA__CRYPTO_CANDLES') }}
order by 1
{% endset %}

{% set results = run_query(payment_method_query) %}

{% if execute %}
{# Return the first column #}
{% set ids = results.columns[0].values() %}
{% else %}
{% set ids = [] %}
{% endif %}

with all_ids as (
    select 'ignore_this_record' as crypto_id
    {% for id in ids %}
    union all
    select '{{ id }}' as crypto_id
    {% endfor %}
)
select * from all_ids
