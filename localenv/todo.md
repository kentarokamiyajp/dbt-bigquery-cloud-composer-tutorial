# To-Do for this BQ project

1. Use all materialized types.[]
   1. table [x]
   2. view []
   3. incremental []
   4. ephemeral []
2. Use macros []
   1. official macros [x]
      1. ```dbt-utils, dbt-expectations```
   2. custom macros [x]
      1. if record count == 0 then do X else do Y [x]
         1. see ```WRK_TEST_*```
      2. quit [x]
         1. see ```WRK_TEST_*```
3. Write basic SQLs []
   1. Create []
      1. with table definition [x]
         1. Need to cast all columns if you need to specify a specific data type.
            1. ```CRYPTO_CANDLES```
      2. from multiple source datasets [x]
         1. ```WRK_CANDLES_DAY_MINUTE```
      3. partitioned table [x]
         1. require_partition_filter: anyone querying this model must specify a partition filter
         2. ```WRK_EX_SPDB__CRYPTO_CANDLES```
      4. primary key [x]
         1. In bigquery itself, there is no enforced primary key. (There is a primary key, but it's not enforced. Double insertion is allowed.)
         2. So, to check the uniqueness, additional unique testing is needed.
         3. Before inserting to the final table, must test the table is expected by creating WRK table or something.
         4. ```CRYPTO_CANDLES```
   2. Insert&Delete []
      1. [materialized=table] []
         1. delete all -> insert -> delete (by macro)
            1. This case is not gonna happen !!!
      2. [materialized=incremental] []
         1. delete (by macro) -> insert
   3. Merge []
   4. Update []
4. Testings
   1. Column data types [x]
   2. Table exists [x]
   3. unique [x]
   4. not null [x]
   5. schema change
      1. We only detect when we use "materialized = incremental"
5. Seeds [x]
6. Revert when model is broken
   1. Before inserting into the final bigquery table, need to test first.
   2. After passing the test, then we can insert the data into the final table.
      1. dbt run --select wrk1
      2. dbt run --select wrk2
      3. dbt run --select wrk3
      4. dbt test --select wrk3
      5. dbt run --select final (only if the test passes)
   3. If there is no wrk table, then test the source table first.
      1. dbt test --select source:src1
      2. dbt run --select final (only if the test passes)
