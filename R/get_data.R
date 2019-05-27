#' Get phenotype data
#'
#' Get phenotype data
#'
#' @param dataset Short abbreviation for a dataset, or name of a group
#' @param trait Optional trait name
#' @param url The URL for the GeneNetwork API
#'
#' @return A data frame, either with traits as rows and samples as columns,
#' or with each sample as a row and columns being detailed information for a single trait
#'
#' @export
#'
#' @examples
#' ph1 <- get_pheno("B30_K_1206_R")
#' ph2 <- get_pheno("BXD", "10002")
#' ph3 <- get_pheno("HC_M2_0606_P", "1436869_at")
get_pheno <-
    function(dataset, trait=NULL, url=gnapi_url())
{
    stopifnot(length(dataset)==1)

    if(is.null(trait)) {
        result <- query_gn(paste0("sample_data/", dataset), url)
    } else {
        stopifnot(length(trait)==1)
        result <- query_gn(paste0("sample_data/", dataset, "/", trait), url)
        if(length(unique(vapply(result, length, 1)))==1) {
            result <- gn_list2df(result)
        }
    }

    result
}
