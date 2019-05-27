## R/GNapi - R package to connect to the [GeneNetwork](http://gn2.genenetwork.org/) API

[![Build Status](https://travis-ci.org/kbroman/GNapi.svg?branch=master)](https://travis-ci.org/kbroman/GNapi)

---

### Installation

You can install R/GNapi from
[GitHub](https://github.com/kbroman/GNapi).

You first need to install the
[devtools](https://github.com/hadley/devtools).

    install.packages("devtools")

Then use `devtools::install_github()` to install R/GNapi.

    library(devtools)
    install_github("kbroman/GNapi")

---

### Usage

For an understanding of the
[GeneNetwork](http://gn2.genenetwork.org) API, see
[its documentation](https://github.com/zsloan/genenetwork2/blob/master/api_readme.md).

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
- `list_probesets("CB_M_1004_P", 100, 101)` - List a slice of
  probesets for gene expression microarray type phenotypes.
- `get_probeset("CB_M_1004_P", "1445618_at_B")` - Get phenotype values
  for a given probeset in a given dataset.
- `info_geno("BXD")` - Get meta information for the genotypes for a given cross.
- `get_geno("BXD")` - Get genotype data for a given cross.
- `get_gmap("BXD")` - Get genetic (and physical) marker maps for a given cross.

We enforce a delay between calls to the API, to slow repeated calls
within a loop. The default is 1 sec; it can be controlled with the
option `GNapi_delay`. For example, to make the delay 0.5 seconds, use:

```r
options(GNapi_delay=0.5)
```

---

### License

[R/GNapi](https://github.com/kbroman/GNapi) is released under the
[MIT license](LICENSE.md).
