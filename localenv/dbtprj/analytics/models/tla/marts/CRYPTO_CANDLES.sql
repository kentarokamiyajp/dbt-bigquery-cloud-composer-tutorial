{{ config(
    materialized='table',
    partition_by={
        "field": "dt",
        "granularity": "day"
    },
    labels = {'contains_pii': 'no', 'contains_id': 'yes', 'company_data':''}
    )
}}

-- time_ingestion_partitioning: Partitioned by date when ingesting. Not partitioned by a column in a model.

with final as (
    select
        CAST(id as STRING) as id,
        CAST(low as FLOAT64) as low,
        CAST(high as FLOAT64) as high,
        CAST(open as FLOAT64) as open,
        CAST(close as FLOAT64) as close,
        CAST(volume as FLOAT64) as volume,
        CAST(dt as DATE) as dt
    from {{ ref('WRK_EX_SPDB__CRYPTO_CANDLES') }}
)
select * from final
