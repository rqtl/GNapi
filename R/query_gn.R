# query genenetwork API
# convert to list if necessary
#' @importFrom httr GET content stop_for_status
query_gn <-
    function(query=NULL, url=gnapi_url())
{
    if(!is.null(query)) url <- paste0(url, "/", query)

    result <- httr::GET(url)
    httr::stop_for_status(result)
    result <- httr::content(result)

    check_gn_error(result)
}

# check whether the result is an error
check_gn_error <-
    function(result)
{
    if(length(result) == 1 && names(result)=="errors" &&
       length(result$errors)==1 && length(result$errors[[1]])==4 &&
       all(names(result$errors[[1]]) == c("detail", "source", "status", "title"))) {
        # looks like an error

        if(length(result$errors[[1]]$status) == 1 && result$errors[[1]]$status==204 &&
           length(result$errors[[1]]$title) == 1 && result$errors[[1]]$title=="No Results") {
            return(NULL)
        }
        else {
            stop("Error ", result$errors[[1]]$status, " ",
                 result$errors[[1]]$title)
        }
    }

    result
}
