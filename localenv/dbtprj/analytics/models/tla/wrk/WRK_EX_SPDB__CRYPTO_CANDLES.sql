{{ config(
    materialized='table',
    partition_by={
        "field": "dt",
        "data_type": "date",
        "granularity": "day"
    },
    labels = {'contains_pii': 'no', 'contains_id': 'yes', 'company_data':''}
)}}

select *  from {{ source('CMN__EX_SPDB_RAW','SPDB__CRYPTO_CANDLES') }}