{{ config(
    materialized='incremental',
    incremental_strategy = 'merge',
    post_hook = [
        "delete from {{ this }} where dt = CURRENT_DATE"
    ]
    )
}}

{# This is comment by jinja #}
{# insert -> delete partial data by post_hook #}

WITH FINAL AS (
    SELECT
    *
    FROM
        {{ source('TRVANALYT_RAW','RESERVATION_D_BOOKINGS') }}
    WHERE dt >= DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)
)
SELECT * FROM FINAL
