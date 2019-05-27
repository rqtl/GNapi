#' Metadata about a dataset
#'
#' Get metadata about a dataset
#'
#' @param dataset The short abbreviation for the dataset
#' @param url The URL for the GeneNetwork API
#'
#' @return A list
#'
#' @export
#'
#' @examples
#' g <- list_groups()
#' d <- list_datasets(g$Name[8])
#' info <- info_dataset(d$Short_Abbreviation[1])
info_dataset <-
    function(dataset, url=gnapi_url())
{
    stopifnot(!is.null(dataset), length(dataset) == 1)

    query_gn(paste0("dataset/", dataset), url)
}

#' Metadata about all datasets for a group
#'
#' Get metadata about all datasets for a group
#'
#' @param group Name of a group of datasets
#' @param url The URL for the GeneNetwork API
#'
#' @return A data frame, with one dataset per row
#'
#' @export
#'
#' @examples
#' g <- list_groups()
#' info <- info_datasets(g$Name[8])
info_datasets <-
    function(group, url=gnapi_url())
{
    datasets <- list_datasets(group, url)
    if(is.null(datasets)) return(NULL)

    listresult <- lapply(datasets$Short_Abbreviation, info_dataset, url)
    gn_list2df( listresult )

}
