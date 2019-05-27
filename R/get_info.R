#' Metadata about a dataset
#'
#' Get metadata about a dataset
#'
#' @param dataset The short abbreviation for the dataset
#' @param url The URL for the GeneNetwork API
#'
#' @return A list
#'
#' @examples
#' g <- list_groups()
#' d <- list_datasets(g$Name[8])
#' info <- info_dataset(d$Short_Abbreviation[1])
info_dataset <-
    function(dataset, url=gnapi_url())
{
    query_gn(paste0("dataset/", dataset), url)
}

# Could add info_datasets, which runs info_dataset for one dataset
# at a time from a particular group
