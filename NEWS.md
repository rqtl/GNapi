## GNapi 0.3-7 (2022-10-25)

### Bug fixes

- `run_gemma()` and `run_rqtl()` are working again.

- Trapped additional errors by looking for `Error:` in title of
  output. (in new internal function `error_in_title()`)


## GNapi 0.3-6 (2022-09-26)

### Bug fixes

- `get_geno()` is working again

- `info_pheno()` can no longer get a list of traits within a group

- `list_groups()` no longer takes an individual group name


## GNapi 0.3-4 (2021-11-17)

### Bug fixes

- Small change in `query_gn()` to change NULL output to NA.


## GNapi 0.3-3 (2020-12-06)

### Minor changes

- Fix a typo in an argument option in `run_rqtl()`.


## GNapi 0.3-2 (2019-06-10)

### Major changes

- Switched to the proper API url,
  `gn2.genenetwork.org/api/pre_v1`

### Minor changes

- Fixed `run_gemma()`, `run_rqtl()`, and `run_correlations()` as
  genenetwork API changed (now giving JSON output)

- `list_groups()` can be used to get information for a specific group.

- `list_datasets()` can be used to get information for a specific dataset.

- Remove `info_dataset()` and `info_datasets()`; for both can be just
  use `list_datasets()`.

- Include `limit` argument for `info_pheno()`.

### Bug fixes

- `list_groups()` was messed up when a species was provided.

- Fix `get_geno()` so it returns `NULL` if the result has no data.


## GNapi 0.2-2 (2019-05-29)

### Major changes

- Complete re-write due to complete re-write of the API
