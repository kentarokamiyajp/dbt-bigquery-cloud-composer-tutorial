{{ config(
    materialized='incremental',
    incremental_strategy = 'insert_overwrite',
    partition_by={
        "field": "dt_create_utc",
        "data_type": "DATE",
        "granularity": "day",
        "copy_partitions": true
    }
    )
}}

select
 *
from
    {{ source('TLA__TRVANALYT_RAW', 'TLA__CRYPTO_CANDLES_MINUTE_3') }}
{% if is_incremental() %}
    where dt_create_utc in ('2024-01-03','2024-01-04')
{% endif %}
