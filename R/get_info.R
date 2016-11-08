#' Get info about a cross
#'
#' Get info about a cross
#'
#' @param cross Name of cross, as single character string
#' @param url URL for GeneNetwork API
#'
#' @return A list
#'
#' @importFrom httr GET content stop_for_status
#' @export
#'
#' @examples
#' info_cross("BXD")
info_cross <-
    function(cross, url="http://test-gn2.genenetwork.org/api_pre1/")
{
    # cross should be a single character string
    stopifnot(!is.null(cross), length(cross) == 1)

    result <- httr::GET(paste0(url, "group/", cross, ".json"))
    httr::stop_for_status(result)

    httr::content(result)
}

#' Get info about a dataset
#'
#' Get info about a dataset
#'
#' @param dataset Name of dataset, as single character string
#' @param url URL for GeneNetwork API
#'
#' @return A list
#'
#' @importFrom httr GET content stop_for_status
#' @export
#'
#' @examples
#' info_dataset("HC_U_0304_R")
info_dataset <-
    function(dataset, url="http://test-gn2.genenetwork.org/api_pre1/")
{
    # dataset should be a single character string
    stopifnot(!is.null(dataset), length(dataset) == 1)

    result <- httr::GET(paste0(url, "dataset/", dataset, ".json"))
    httr::stop_for_status(result)

    httr::content(result)
}

#' Get meta information for genotypes
#'
#' Get meta information for the genotypes for a cross
#'
#' @param cross Cross name as a single character string
#' @param url URL for GeneNetwork API
#'
#' @return Matrix with genotypes; rows are markers, columns are strains
#'
#' @importFrom httr GET content stop_for_status
#' @export
#'
#' @examples
#' info_geno("BXD")
info_geno <-
    function(cross, url="http://test-gn2.genenetwork.org/api_pre1/")
{
    # call info_cross to determine species
    info <- info_cross(cross, url)
    if(!("species" %in% names(info)))
        stop("Can't find species for cross ", cross)
    species <- info$species

    # now call to get genotypes
    result <- httr::GET(paste0(url, "genotype/", species, "/",
                               cross, ".json"))
    stop_for_status(result)

    httr::content(result)
}
