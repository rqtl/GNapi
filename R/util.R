# grab some element from each of a list of lists
# if NULL, convert to NA using a particular type
grab_elements <-
    function(v, index, null_value=as.character(NA))
{
    sapply(v, function(a) ifelse(length(a) < index || is.null(a[[index]]), null_value, a[[index]]))
}
