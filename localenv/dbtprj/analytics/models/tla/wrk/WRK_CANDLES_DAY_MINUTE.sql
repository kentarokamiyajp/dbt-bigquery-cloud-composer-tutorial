with candles_day as (
    select *  from {{ source('CMN__EX_SPDB_RAW','SPDB__CRYPTO_CANDLES') }}
),
candles_minute as (
    select *  from {{ source('TLA__TRVANALYT_RAW','TLA__CRYPTO_CANDLES_MINUTE_1') }}
),
final as (
    select
        A.id,
        A.low,
        A.high,
        A.open,
        A.close,
        B.interval_type
    from candles_day as A
    left join candles_minute as B
    on A.id = B.id
)
select * from final
