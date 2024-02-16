{{ config(
    materialized='incremental',
    incremental_strategy = 'merge'
    )
}}

{# This is comment by jinja #}
{# insert (append), no delete #}

WITH FINAL AS (
    SELECT
    *
    FROM
        {{ source('TRVANALYT_RAW','RESERVATION_D_BOOKINGS') }}
    WHERE 
        dt >= DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)
)
SELECT * FROM FINAL
