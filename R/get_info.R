#' Get summary information about a phenotype
#'
#' Get summary information about a phenotype
#'
#' @param group Name of a group of datasets
#' @param trait Trait identifier (can be a vector)
#' @param limit Limit on number of traits to return (if `trait` is `NULL`)
#' @param url The URL for the GeneNetwork API
#'
#' @return A data frame
#'
#' @export
#'
#' @examples
#' info_pheno("BXD", "10002")
#' info_pheno("HC_M2_0606_P", limit=10)
#' info_pheno("HC_M2_0606_P", "1436869_at")
#' info_pheno("HXBBXH", limit=10)
info_pheno <-
    function(group, trait=NULL, limit=NULL, url=gnapi_url())
{
    stopifnot(length(group)==1)
    if(is.null(trait) || trait == "") {
        query <- paste0("traits/", group)
        if(!is.null(limit)) {
            query <- paste0(query, "?limit_to=", limit)
        }
        result <- query_gn(query, url)
        return(list2df(result))
    }

    if(length(trait) > 1) {
        result <- lapply(trait, function(trt) info_pheno(group, trait=trt, url=url))
        return(do.call("rbind_expand", result))
    }

    result <- query_gn(paste0("trait/", group, "/", trait), url=url)

    if(is.null(result)) return(result)

    # convert to a data frame
    result <- list2df(list(result))
    rownames(result) <- trait

    result
}
