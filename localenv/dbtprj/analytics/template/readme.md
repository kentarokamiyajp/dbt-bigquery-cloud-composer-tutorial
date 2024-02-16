# DBT model template

## sources.yml and models.yml

1. sources.yml is a config for source dataset such as TRVL_RAW, TRVANALYT_RAW
   1. ```sources.yml```
2. models.yml is a config for models (mart dataset)
   1. ```models.yml```

## DML

1. delete all data (drop table) -> insert
   1. ```delete_all__insert.sql```
2. delete partial data -> insert
   1. ```delete_partial__insert.sql```
3. insert (append), no delete (run_query, not pre_hook, but can use pre_hook as well)
   1. ```only_insert.sql```
4. insert (append) -> delete (post_hook)
   1. ```insert__delete_partial.sql```
5. delete only
   1. Cannot do this in DBT.
   2. ```If a bteq file has only deletion, it needs to be merged into another one with insertion.```
6. merge
   1. ```merge.sql```
7. update
   1. Need to modify to use "merge" query.

## DML with IF ELSE condition

1. record count == 0 then do X else do Y
   1. ```check_row_count.sql```
2. quit if we get unexpected result
   1. ```check_row_count.sql```

## Ephemeral model

- ```ephemeral.sql```

## Seeds

- config file
  - ```properties.yml```

## Macros

- sample macro
  - ```get_row_count.sql```