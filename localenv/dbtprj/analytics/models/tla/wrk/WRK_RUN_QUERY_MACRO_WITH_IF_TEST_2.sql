{% set payment_method_query %}
select 
    id,dt
from 
    {{ source('TLA__TRVANALYT_RAW','TLA__CRYPTO_CANDLES') }}
order by 1
{% endset %}

{% set results = run_query(payment_method_query) %}

{% if execute %}
{# Return the first column #}
{% set ids = results.columns[0].values() %}
{% set dts = results.columns[1].values() %}
{% set id_dt = zip(ids, dts) %}
{% else %}
{% set id_dt = [] %}
{% endif %}

with all_ids as (
    select 'ignore_this_record' as id, 'ignore_this_record' as dt
    {% for (id,dt) in id_dt %}
    union all
    select '{{ id }}' as id, '{{ dt }}' as dt
    {% endfor %}
)
select * from all_ids
