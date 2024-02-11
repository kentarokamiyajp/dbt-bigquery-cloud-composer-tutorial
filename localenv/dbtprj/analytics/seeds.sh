#!/bin/bash
dbt seed --profiles-dir . --target dev --profile tla_seed --select TLA__CRYPTO_CANDLES
dbt test --profiles-dir . --target dev --profile tla_seed --select TLA__CRYPTO_CANDLES

dbt seed --profiles-dir . --target dev --profile tla_seed --select TLA__CRYPTO_CANDLES_MINUTE_1
dbt seed --profiles-dir . --target dev --profile tla_seed --select TLA__CRYPTO_CANDLES_MINUTE_2
dbt seed --profiles-dir . --target dev --profile tla_seed --select TLA__CRYPTO_CANDLES_MINUTE_3
dbt test --profiles-dir . --target dev --profile tla_seed --select TLA__CRYPTO_CANDLES_MINUTE_1

dbt seed --profiles-dir . --target dev --profile ex_spdb --select SPDB__CRYPTO_CANDLES
dbt test --profiles-dir . --target dev --profile ex_spdb --select SPDB__CRYPTO_CANDLES