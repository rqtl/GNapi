#' Check if GeneNetwork is live
#'
#' Check if GeneNetwork is live
#'
#' @param url URL for GeneNetwork
#'
#' @return Character string.
#'
#' @importFrom httr GET content stop_for_status
#' @export
#'
#' @examples
#' check_gn()
check_gn <-
    function(url=gnapi_url())
{
    result <- httr::GET(url)
    httr::stop_for_status(result)
    listresult <- httr::content(result)

    nam <- names(listresult)
    if(length(nam)==1 && nam=="hello") {
        if(listresult[["hello"]] == "world") {
            return("GN says hello.")
        }
    }

    stop("result not as expected:", listresult)
}
