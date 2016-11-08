#' Get list of species
#'
#' Get list of available species
#'
#' @param url URL for GeneNetwork API
#'
#' @return Data frame with number, species common name and formal name.
#'
#' @importFrom httr GET content stop_for_status
#' @export
#'
#' @examples
#' list_species()
list_species <-
    function(url="http://test-gn2.genenetwork.org/api_pre1/")
{
    result <- httr::GET(paste0(url, "species"))
    listresult <- httr::content(result)
    httr::stop_for_status(result)

    # convert to data frame
    data.frame(id = grab_elements(listresult, 1, as.numeric(NA)),
               common = grab_elements(listresult, 2, as.character(NA)),
               species =grab_elements(listresult, 3, as.character(NA)),
               stringsAsFactors=FALSE)
}

#' List available datasets for a cross
#'
#' List available datasets for a cross.
#'
#' @param cross Name of cross, as single character string
#' @param url URL for GeneNetwork API
#'
#' @return A data frame with dataset ID, name, and description
#'
#' @importFrom httr GET content stop_for_status
#' @export
#'
#' @examples
#' list_datasets("BXD")
list_datasets <-
    function(cross, url="http://test-gn2.genenetwork.org/api_pre1/")
{
    # cross should be a single character string
    stopifnot(!is.null(cross), length(cross) == 1)

    result <- httr::GET(paste0(url, "datasets/", cross))
    listresult <- httr::content(result)
    httr::stop_for_status(result)

    data.frame(id=vapply(listresult, "[[", 0, 1),
               name=grab_elements(listresult, 2),
               description=grab_elements(listresult, 3),
               stringsAsFactors=FALSE)
}
