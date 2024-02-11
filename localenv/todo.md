# To-Do for this BQ project

1. Use all materialized types.[]
   1. table [x]
   2. view []
   3. incremental []
   4. ephemeral []
2. Use macros []
   1. official macros []
   2. custom macros []
      1. if record count == 0 then do X else do Y []
      2. quit []
3. Write basic SQLs []
   1. Create []
      1. with table definition []
      2. from multiple source datasets []
      3. partitioned table []
         1. require_partition_filter: anyone querying this model must specify a partition filter
      4. primary key []
         1. In bigquery itself, there is no enforced primary key. (There is a primary key, but it's not enforced. Double insertion is allowed.)
         2. So, to check the uniqueness, additional unique testing is needed.
         3. Before inserting to the final table, must test the table is expected by creating WRK table or something.
      5. 
   2. Drop []
   3. Delete []
      1. delete all data []
      2. delete partial data []
   4. Insert []
   5. Insert and Delete combination []
   6. Merge []
   7. Update []
4. Testings
   1. Column data types [x]
   2. Table exists [x]
   3. unique
   4. not null
   5. schema change
5. Seeds [x]
6. Rollback
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
