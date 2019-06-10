## R/GNapi - R package to connect to the [GeneNetwork](http://gn2.genenetwork.org/) API

[![Build Status](https://travis-ci.org/rqtl/GNapi.svg?branch=master)](https://travis-ci.org/rqtl/GNapi)

---

### Installation

You can install R/GNapi from
[GitHub](https://github.com/rqtl/GNapi).

You first need to install the
[devtools](https://github.com/hadley/devtools).

    install.packages("devtools")

Then use `devtools::install_github()` to install R/GNapi.

    library(devtools)
    install_github("rqtl/GNapi")

---

### Usage

For an understanding of the
[GeneNetwork](http://gn2.genenetwork.org) API, see
[its
documentation](https://github.com/zsloan/genenetwork2/blob/master/api_readme.md),
as well as [Zachary Sloan](https://github.com/zsloan?tab=repositories)'s
[tutorial](https://github.com/zsloan/GN2-REST-Notebook/blob/master/REST_guide.ipynb).


The R/GNapi package has a set of functions for connecting to the
GeneNetwork API to grab different bits of information or data.

- `check_gn()` - Check connection.
- `list_species()` - List available species.
- `list_groups("drosophila")` - List available groups of datasets
- `list_datasets("BXD")` - List available datasets for a given group
  (here, `"BXD"`).
- `info_dataset("CB_M_1004_P")` - Get meta information about a data set.
- `info_datasets("B6D2F2")` - Get meta information about all data sets
  for a group.
- `info_pheno()` - Get summary information for a phenotype
- `get_pheno("BXD", "10646")` - Get phenotype values for a classical trait.
- `get_geno("BXD")` - Get genotypes for a group.
- `run_gemma("BXDPublish", "10015")` - Perform a genome scan with [gemma](https://github.com/genetics-statistics/GEMMA)
- `run_rqtl("BXDPublish", "10015")` - Perform a genome scan with [R/qtl](http://rqtl.org)
- `run_correlation("HC_M2_0606_P", "BXDPublish", "1427571_at")` - Finds traits that are correlated with a given trait.

For further examples, see the [online
vignette](https://kbroman.org/GNapi/GNapi.html), which is also
available from within R:

```r
vignette("GNapi")
```

Note that we enforce a delay between calls to the API, to slow
repeated calls within a loop. The default is 1 sec; it can be
controlled with the option `GNapi_delay`. For example, to make the
delay 0.5 seconds, use:

```r
options(GNapi_delay=0.5)
```

---

### License

[R/GNapi](https://github.com/rqtl/GNapi) is released under the
[MIT license](LICENSE.md).
