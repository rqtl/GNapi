#' Metadata about a dataset
#'
#' Get metadata about a dataset
#'
#' @param dataset The short abbreviation for the dataset
#' @param url The URL for the GeneNetwork API
#'
#' @return A data frame with a single row
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
    stopifnot(length(dataset) == 1)

    result <- query_gn(paste0("dataset/", dataset), url)

    # convert to data frame
    list2df( list(result) )
}

#' Metadata about all datasets for a group
#'
#' Get metadata about all datasets for a group
#'
#' @param group Name of a group of datasets
#' @param url The URL for the GeneNetwork API
#'
#' @return A data frame
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

    do.call("rbind_expand", lapply(datasets$Short_Abbreviation, info_dataset, url))
}

#' Get summary information about a phenotype
#'
#' Get summary information about a phenotype
#'
#' @param group Name of a group of datasets
#' @param trait Trait identifier (can be a vector)
#' @param url The URL for the GeneNetwork API
#'
#' @return A data frame
#'
#' @export
#'
#' @examples
#' info_pheno("BXD", "10002")
info_pheno <-
    function(group, trait, url=gnapi_url())
{
    stopifnot(length(group)==1)
    if(length(trait) > 1) {
        result <- lapply(trait, function(trt) info_pheno(group, trt, url))
        return(do.call("rbind_expand", result))
    }

    result <- query_gn(paste0("trait/", group, "/", trait), url)

    # convert to a data frame
    result <- list2df(list(result))
    rownames(result) <- trait

    result
}
