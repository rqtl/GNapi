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
    data.frame(number = vapply(listresult, "[[", 0, 1),
               common = vapply(listresult, "[[", "", 2),
               species =vapply(listresult, "[[", "", 3),
               stringsAsFactors=FALSE)
}
