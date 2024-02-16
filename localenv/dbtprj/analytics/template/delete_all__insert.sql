{{ config(
    materialized='table',
    partition_by={
        "field": "dt",
        "data_type": "date",
        "granularity": "day"
    },
    cluster_by = ['dt'],
    labels = {'contains_pii': 'no', 'contains_easyid': 'yes'}
    )
}}

{# This is comment by jinja #}
{# delete all data (drop table) -> insert #}

WITH TMP_1 AS (
    SELECT
        id,
        dt
    FROM {{ source('TRVANALYT_RAW','RESERVATION_D_BOOKINGS') }}
),
TMP_2 AS (
    SELECT
        id,
        dt
    FROM {{ source('TRVANALYT_RAW','RESERVATION_D_BOOKINGS') }}
),
FINAL AS (
    SELECT * FROM TMP_1
    UNION ALL
    SELECT * FROM TMP_2
)
SELECT * FROM FINAL
