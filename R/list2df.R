# convert list (indexes as [[row]][[column]] to a data frame
list2df <-
    function(listresult)
{
    if(is.null(listresult)) return(listresult)

    do.call("rbind_expand", listresult)

}
