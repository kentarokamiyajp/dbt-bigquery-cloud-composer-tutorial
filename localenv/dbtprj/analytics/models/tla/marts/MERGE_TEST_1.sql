{{ config(
    materialized='incremental',
    incremental_strategy = 'merge',
    partition_by={
        "field": "ts_create_utc",
        "data_type": "timestamp",
        "granularity": "hour"
    },
    cluster_by = ['dt_create_utc'],
    unique_key = ['id', 'starttime'],
    merge_update_columns = [
        'low',
        'high',
        'open',
        'close',
        'amount',
        'quantity',
        'buytakeramount',
        'buytakerquantity',
        'tradecount'
    ],
    incremental_predicates = ["DBT_INTERNAL_DEST.dt_create_utc >= DATE_SUB('2024-01-03', INTERVAL 1 DAY)"]
    )
}}

-- unique_key: if set, it'll merge operation. if not set, it'll only insert operation.
-- merge_update_columns: specified columns in this list will be updated. others are not updated.
-- Need to run 3 times: TLA__CRYPTO_CANDLES_MINUTE_1 -> TLA__CRYPTO_CANDLES_MINUTE_2 -> TLA__CRYPTO_CANDLES_MINUTE_3
select
 *
from
    {{ source('TLA__TRVANALYT_RAW', 'TLA__CRYPTO_CANDLES_MINUTE_3') }}
{% if is_incremental() %}
where dt_create_utc >= DATE_SUB('2024-01-03', INTERVAL 1 DAY)
{% endif %}
