{{ config(
    materialized = 'incremental',
    incremental_strategy = 'merge',
    unique_key = ['id','dt'],
    merge_update_columns = [ 'dt' ],
    incremental_predicates = ["DBT_INTERNAL_DEST.dt >= DATE_SUB(CURRENT_DATE, INTERVAL 7 DAY)"]
) }}

{# This is comment by jinja #}
{# merge opreration #}
{# Columns in the unique_key list are used for condition in merge query #}
{# E.g., "MERGE target_tbl t USING source_tbl s ON s.id = t.id and s.dt = t.dt ..." #}
{# If we set 'merge_update_columns', only the columns in the list will be update. #}

WITH FINAL AS (
    SELECT
        *
    FROM
        {{ source('TRVANALYT_RAW','RESERVATION_D_BOOKINGS') }}
    {% if is_incremental() %}
        WHERE dt >= DATE_SUB(CURRENT_DATE,INTERVAL 7 DAY)
    {% endif %}
)
SELECT * FROM FINAL
