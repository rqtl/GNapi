#' Get list of species
#'
#' Get list of available species
#'
#' @param species Optional character string, to obtain a particular, single species
#' @param url URL for GeneNetwork API
#'
#' @return Data frame with columns `FullName`, `Id`, `Name`, and `TaxonomyId`.
#'
#' @seealso [list_groups()], [list_datasets()]
#'
#' @export
#'
#' @examples
#' list_species()
list_species <-
    function(species=NULL, url=gnapi_url())
{
    if(!is.null(species)) {
        stopifnot(length(species)==1)
        result <- query_gn(paste0("species/", species), url=url)
        return(list2df(list(result)))
    }

    result <- query_gn("species", url=url)

    list2df(result)
}


#' Get list of groups
#'
#' Get list of available groups
#'
#' @param species Optional species name, for just the groups for that species.
#' @param group Optional name for a specific group
#' @param url URL for GeneNetwork API
#'
#' @return Data frame with columns `FullName`, `Id`, `Name`, and `TaxonomyId`.
#'
#' @seealso [list_species()], [list_datasets()]
#'
#' @export
#'
#' @examples
#' list_groups()
#' list_groups("barley")
#' list_groups("rat", "HSNIH-Palmer")
#' list_groups(group="HSNIH-Palmer")
list_groups <-
    function(species=NULL, group=NULL, url=gnapi_url())
{
    if(!is.null(group) && group != "") { # note this uses group/ rather than groups/
        query <- "group/"
        if(!is.null(species) && species != "") {
            query <- paste0(query, "/", species)
        }
        result <- query_gn(paste0(query, "/", group), url=url)
        if(is.null(result)) return(NULL)
        return(as.data.frame(result))
    }
    else if(!is.null(species) && species != "") {
        stopifnot(length(species)==1)
        result <- query_gn(paste0("groups/", species), url=url)
    } else {
        result <- query_gn("groups", url=url)
    }

    list2df(result)
}


#' List available datasets for a group
#'
#' List available datasets for a group.
#'
#' @param group Name of group, as single character string
#' @param dataset Optional name of a specific dataset
#' @param url URL for GeneNetwork API
#'
#' @return A data frame with dataset ID, name, and description
#'
#' @seealso [list_species()], [list_groups()]
#'
#' @export
#'
#' @examples
#' list_datasets("BXD")
list_datasets <-
    function(group, dataset=NULL, url=gnapi_url())
{
    # group should be a single character string
    stopifnot(length(group) == 1)

    if(!is.null(dataset) && dataset != "") {
        result <- query_gn(paste0("dataset/", group, "/", dataset),
                           url=url)
        if(is.null(result)) return(NULL)
        return(as.data.frame(result))
    }

    result <- query_gn(paste0("datasets/", group), url=url)

    list2df( result )
}
