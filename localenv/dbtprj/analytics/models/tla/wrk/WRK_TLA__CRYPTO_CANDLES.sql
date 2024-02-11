{{ config(
    materialized='table',
    partition_by={
        "field": "dt",
        "granularity": "day",
        "time_ingestion_partitioning": true
    },
    labels = {'contains_pii': 'no', 'contains_id': 'yes', 'company_data':''}
    )
}}

-- time_ingestion_partitioning: Partitioned by date when ingesting. Not partitioned by a column in a model.

select *  from {{ source('TLA__TRVANALYT_RAW','TLA__CRYPTO_CANDLES') }}