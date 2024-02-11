{% set partitions_to_replace = [
    "DATE('2024-01-04')",
    "DATE(date_sub('2024-01-04', interval 1 day))"
] %}

{{ config(
    materialized='incremental',
    incremental_strategy = 'insert_overwrite',
    partition_by={
        "field": "dt_create_utc",
        "data_type": "DATE",
        "granularity": "day"
    },
    partitions = partitions_to_replace
    )
}}

select
 *
from
    {{ source('TLA__TRVANALYT_RAW', 'TLA__CRYPTO_CANDLES_MINUTE_3') }}
{% if is_incremental() %}
    -- recalculate yesterday + today
    where dt_create_utc in ({{ partitions_to_replace | join(',') }})
{% endif %}
