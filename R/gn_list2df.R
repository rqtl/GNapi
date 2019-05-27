# convert list (indexes as [[row]][[column]] to a data frame
gn_list2df <-
    function(listresult)
{
    if(is.null(listresult)) return(listresult)

    # check that the results could be made into a data frame
    lengths <- vapply(listresult, length, 0)
    if(!all(lengths==lengths[1])) {
        stop("varying lengths in the result")
    }

    if(!all(vapply(listresult, function(a) all(names(a)==names(listresult[[1]])), FALSE))) {
        stop("varying names in the result")
    }

    # rearrange list
    result <- lapply(seq_along(listresult[[1]]), function(i) lapply(listresult, "[[", i))

    # turn NULLs into NAs
    result <- lapply(result, function(v) {
        sapply(v, function(vv) ifelse(is.null(vv), NA, vv)) })

    # convert result to data frame
    result <- as.data.frame(result, stringsAsFactors=FALSE)
    names(result) <- names(listresult[[1]])

    result
}
