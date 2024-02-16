{{ config(
    materialized='ephemeral'
)
}}

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
