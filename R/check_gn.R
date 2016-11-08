#' Check if GeneNetwork is live
#'
#' Check if GeneNetwork is live
#'
#' @param url URL for GeneNetwork
#'
#' @return Version number (as a character string)
#'
#' @importFrom httr GET content stop_for_status
#' @export
#'
#' @examples
#' check_gn()
check_gn <-
    function(url="http://test-gn2.genenetwork.org/api_pre1/")
{
    result <- httr::GET(url)

    listresult <- httr::content(result)

    httr::stop_for_status(result)

    nam <- names(listresult)
    if(length(nam)==2 && all(sort(nam) == c("I am", "version"))) {
        if(listresult[["I am"]] == "genenetwork")
            return(listresult$version)
    }

    stop("result not as expected:", listresult)
}
