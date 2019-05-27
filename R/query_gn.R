# query genenetwork API
# convert to list if necessary
#' @importFrom httr GET content stop_for_status
query_gn <-
    function(query=NULL, url=gnapi_url())
{
    if(!is.null(query)) url <- paste0(url, "/", query)

    result <- httr::GET(url)
    httr::stop_for_status(result)
    httr::content(result)
}

gn_list_to_df <-
    function(listresult)
{
    # check that the results could be made into a data frame
    lengths <- vapply(listresult, length, 0)
    if(!all(lengths==lengths[1])) {
        stop("varying lengths in the result")
    }

    if(!all(vapply(listresult, function(a) all(names(a)==names(listresult[[1]])), FALSE))) {
        stop("varying names in the result")
    }

    # convert result to data frame
    result <- as.data.frame(lapply(seq_along(listresult[[1]]),
           function(i) vapply(listresult, "[[", listresult[[1]][[i]], i)))
    names(result) <- names(listresult[[1]])

    result
}
