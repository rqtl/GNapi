#' Check if GeneNetwork is live
#'
#' Check if GeneNetwork is live
#'
#' @param url URL for GeneNetwork
#'
#' @return Character string.
#'
#' @export
#'
#' @examples
#' check_gn()
check_gn <-
    function(url=gnapi_url())
{
    listresult <- query_gn(url=url)

    nam <- names(listresult)
    if(length(nam)==1 && nam=="hello") {
        if(listresult[["hello"]] == "world") {
            return("GN says hello.")
        }
    }

    stop("result not as expected:", listresult)
}
