## GNapi 0.3-2 (2019-06-10)

### Major changes

- Switched to the proper API url,
  <https://gn2.genenetwork.org/api/pre_v1>

### Minor changes

- Fixed `run_gemma()`, `run_rqtl()`, and `run_correlations()` as
  genenetwork API changed (now giving JSON output)

### Bug fixes

- `list_groups()` was messed up when a species was provided.

- Fix `get_geno()` so it returns `NULL` if the result has no data.


## GNapi 0.2-2 (2019-05-29)

### Major changes

- Complete re-write due to complete re-write of the API
