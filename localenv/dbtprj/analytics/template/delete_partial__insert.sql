{{ config(
    materialized='incremental',
    incremental_strategy = 'merge'
    )
}}

{# This is comment by jinja #}
{# delete partial data -> insert #}


{# 1. Delete Data #}

{% set query %}
    delete from {{ this }} where dt = CURRENT_DATE
{% endset %}

{# In the first run, this delete macro will not be run #}
{# If we want to run in the first run, remove "if is_incremental()" block #}
{% if is_incremental() %}
    {% do run_query(query) %}
{% endif %}




{# 2. Insert(append) Data #}
{# In the first run, all source data will be inserted #}
{# From the second run, the where condition will be applied #}
WITH FINAL AS (
    SELECT
    *
    FROM
        {{ source('TRVANALYT_RAW','RESERVATION_D_BOOKINGS') }}
    {% if is_incremental() %}
        WHERE dt >= DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)
    {% endif %}
)
SELECT * FROM FINAL

