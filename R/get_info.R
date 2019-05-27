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
    list2df( listresult )

}

#' Get summary information about a phenotype
#'
#' Get summary information about a phenotype
#'
#' @param group Name of a group of datasets
#' @param trait Trait identifier
#' @param url The URL for the GeneNetwork API
#'
#' @return A data frame with a single row
#'
#' @export
#'
#' @examples
#' info_pheno("BXD", "10002")
info_pheno <-
    function(group, trait, url=gnapi_url())
{
    stopifnot(!is.null(group), length(group)==1)
    stopifnot(!is.null(trait), length(trait)==1)

    result <- query_gn(paste0("trait/", group, "/", trait), url)

    # convert to a data frame
    result <- list2df(list(result))
    rownames(result) <- trait

    result
}
