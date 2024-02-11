#!/bin/bash

# Test for source tables
dbt test --profiles-dir . --target dev --profile tla --select "source:TLA__TRVANALYT_RAW"
dbt test --profiles-dir . --target dev --profile tla --select "source:CMN__EX_SPDB_RAW"


# Create wrok tables
dbt run --profiles-dir . --target dev --profile tla --select tla.wrk.WRK_TLA__CRYPTO_CANDLES
dbt run --profiles-dir . --target dev --profile tla --select tla.wrk.WRK_EX_SPDB__CRYPTO_CANDLES

# Create mart tables
