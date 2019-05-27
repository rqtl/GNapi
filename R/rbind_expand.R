# rbind, expanding and reordering columns using their names

rbind_expand <-
    function(...)
{
    input <- list(...)

    # replace NULLs with NAs
    input <- lapply(input, function(v) {
        n <- max(vapply(v, length, 1))
        lapply(v, function(vv) {
            if(is.null(vv)) return(rep(NA, n))
            vv })  })

    # turn into a set of data frames
    input <- lapply(input, as.data.frame, stringsAsFactors=FALSE)

    # all of the names
    all_names <- unique(unlist(lapply(input, names)))

    # expand and reorder
    input <- lapply(input, function(a) {
        names_a <- names(a)
        missing <- !(all_names %in% names_a)
        if(!any(missing)) return(a[,all_names,drop=FALSE])

        to_add <- matrix(nrow=nrow(a), ncol=sum(missing))
        colnames(to_add) <- all_names[missing]

        cbind(a, to_add, stringsAsFactors=FALSE)[,all_names, drop=FALSE]
        } )

    do.call("rbind", input)
}
